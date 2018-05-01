module RubyRedisLock

  LockAcquisitionTimeoutException = Class.new(StandardError)

  def lock(lock_name, processing_timeout=60, acquiring_timout=10)
    lock_acquired = acquire_lock(lock_name, processing_timeout, acquiring_timout)
    yield
  ensure
    release_lock(lock_name, processing_timeout) if lock_acquired
  end

  private

  def acquire_lock(lock_name, processing_timeout=60, acquiring_timeout=10)
    start_time = Time.now.to_i
    while !try_acquire_lock(lock_name, processing_timeout)
      sleep 0.5
      if (Time.now.to_i - start_time) > acquiring_timeout
        raise LockAcquisitionTimeoutException, "Acquiring lock timeout > #{acquiring_timeout} seconds"
      end
    end
    true
  end

  def try_acquire_lock(lock_name, processing_timeout=60)
    ret = self.setnx(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}")
    return true if ret == true

    expiration = self.get(ruby_redis_lock_key(lock_name)).to_i
    return false if Time.now.to_i < expiration

    previous_expiration = self.getset(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}").to_i
    return true if expiration == previous_expiration

    false
  end

  def release_lock(lock_name, processing_timeout=60)
    expiration = self.get(ruby_redis_lock_key(lock_name)).to_i
    return false if Time.now.to_i > expiration

    previous_expiration = self.getset(ruby_redis_lock_key(lock_name), "#{Time.now.to_i + processing_timeout}").to_i

    if expiration == previous_expiration # it still owns the lock
      self.del(ruby_redis_lock_key(lock_name))
      return true
    end

    false
  end

  def ruby_redis_lock_key(lock_name)
    "RubyRedisLock:#{lock_name}"
  end

end