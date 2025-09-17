'use client';

import { useState } from 'react';
import Image from 'next/image';
import { useRouter } from 'next/navigation';

const LoginPage = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    // Simulate login logic
    try {
      // Replace this with actual API call
      if (email === 'admin@recipe.com' && password === 'admin123') {
        localStorage.setItem('isLoggedIn', 'true');
        router.push('/dashboard');
      } else {
        setError('Invalid email or password');
      }
    } catch (err) {
      setError('Login failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="d-flex flex-column flex-root" id="kt_app_root">
      <div className="d-flex flex-column flex-lg-row flex-column-fluid">
        {/* Aside */}
        <div className="d-flex flex-column flex-lg-row-auto bg-orange w-xl-600px positon-xl-relative">
          <div className="d-flex flex-column position-xl-fixed top-0 bottom-0 w-xl-600px scroll-y">
            {/* Header */}
            <div className="d-flex flex-row-fluid flex-column text-center p-5 p-lg-10 pt-lg-20">
              {/* Logo */}
              <a className="py-2 py-lg-20">
                <Image 
                  alt="Logo" 
                  src="/assets/media/illustrations/sigma-1/white-logo.png" 
                  className="h-50px h-lg-100px"
                  width={100}
                  height={100}
                />
              </a>
              
              {/* Title */}
              <h1 className="d-none d-lg-block fw-bold text-white fs-2x pb-5 pb-md-10">
                Welcome to Recipe
              </h1>
              
              {/* Description */}
              <p className="d-none d-lg-block fw-semibold fs-2 text-white">
                Explore a world of delicious flavors with our easy-to-follow recipes designed for any home cook.
              </p>
            </div>
            
            {/* Illustration */}
            <div 
              className="d-none d-lg-block d-flex flex-row-auto bgi-no-repeat bgi-position-x-center bgi-size-contain bgi-position-y-bottom min-h-100px min-h-lg-475px" 
              style={{
                backgroundImage: 'url(/assets/media/illustrations/sigma-1/Restaurant.png)'
              }}
            ></div>
          </div>
        </div>
        
        {/* Body */}
        <div className="d-flex flex-column flex-lg-row-fluid py-10">
          <div className="d-flex flex-center flex-column flex-column-fluid">
            <div className="card">
              <div className="w-lg-600px p-10 p-lg-15 mx-auto">
                {/* Form */}
                <form className="form w-100" onSubmit={handleSubmit} noValidate>
                  {/* Heading */}
                  <div className="text-center mb-10">
                    <h1 className="text-dark mb-3 fw-bolder">Sign In Recipe</h1>
                  </div>
                  
                  {/* Error Alert */}
                  {error && (
                    <div className="alert alert-dismissible bg-light-danger d-flex align-items-center mb-10">
                      <span className="fs-7 text-danger fw-bold text-center ps-5">{error}</span>
                      <button 
                        type="button" 
                        className="btn btn-icon ms-sm-auto" 
                        onClick={() => setError('')}
                      >
                        <i className="ki-duotone ki-cross fs-1 text-danger fw-bold">
                          <span className="path1"></span>
                          <span className="path2"></span>
                        </i>
                      </button>
                    </div>
                  )}
                  
                  {/* Email Input */}
                  <div className="fv-row mb-10">
                    <label className="form-label fs-6 fw-bold text-dark">Email</label>
                    <input 
                      className="form-control form-control-lg form-control-solid" 
                      type="email" 
                      name="email" 
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      autoComplete="off"
                      required
                    />
                  </div>
                  
                  {/* Password Input */}
                  <div className="fv-row mb-10">
                    <div className="d-flex flex-stack mb-2">
                      <label className="form-label fw-bold text-dark fs-6 mb-0">Password</label>
                    </div>
                    <input 
                      className="form-control form-control-lg form-control-solid" 
                      type="password" 
                      name="password" 
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      autoComplete="off"
                      required
                    />
                  </div>
                  
                  {/* Submit Button */}
                  <div className="text-center">
                    <button 
                      type="submit" 
                      className="btn btn-lg btn-primary w-100 mb-5"
                      disabled={loading}
                    >
                      <span className="indicator-label">
                        {loading ? 'Signing In...' : 'Continue'}
                      </span>
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default LoginPage; 