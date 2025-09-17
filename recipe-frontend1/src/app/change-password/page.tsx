'use client';

import { useState } from 'react';
import PageTemplate from '@/components/PageTemplate';

const ChangePasswordPage = () => {
  const [formData, setFormData] = useState({
    currentPassword: '',
    newPassword: '',
    confirmPassword: ''
  });
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');
  const [showPasswords, setShowPasswords] = useState({
    current: false,
    new: false,
    confirm: false
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setSuccess('');

    // Validation
    if (formData.newPassword !== formData.confirmPassword) {
      setError('New password and confirm password do not match');
      setLoading(false);
      return;
    }

    if (formData.newPassword.length < 6) {
      setError('New password must be at least 6 characters long');
      setLoading(false);
      return;
    }

    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      setSuccess('Password changed successfully!');
      setFormData({
        currentPassword: '',
        newPassword: '',
        confirmPassword: ''
      });
    } catch (err) {
      setError('Failed to change password. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const togglePasswordVisibility = (field: 'current' | 'new' | 'confirm') => {
    setShowPasswords(prev => ({
      ...prev,
      [field]: !prev[field]
    }));
  };

  return (
    <PageTemplate
      title="Change Password"
      breadcrumbs={[{ label: 'Profile' }, { label: 'Change Password' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-6 mx-auto">
          {/* Change Password Form */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Change Password</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <form onSubmit={handleSubmit} className="form">
                {/* Success Alert */}
                {success && (
                  <div className="alert alert-dismissible bg-light-success d-flex align-items-center mb-10">
                    <span className="fs-7 text-success fw-bold text-center ps-5">{success}</span>
                    <button 
                      type="button" 
                      className="btn btn-icon ms-sm-auto" 
                      onClick={() => setSuccess('')}
                    >
                      <i className="ki-duotone ki-cross fs-1 text-success fw-bold">
                        <span className="path1"></span>
                        <span className="path2"></span>
                      </i>
                    </button>
                  </div>
                )}

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

                {/* Current Password */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Current Password</label>
                  <div className="position-relative">
                    <input 
                      type={showPasswords.current ? 'text' : 'password'}
                      className="form-control form-control-solid" 
                      placeholder="Enter current password"
                      name="currentPassword"
                      value={formData.currentPassword}
                      onChange={handleChange}
                      required
                    />
                    <button
                      type="button"
                      className="btn btn-icon btn-sm position-absolute end-0 top-50 translate-middle-y me-3"
                      onClick={() => togglePasswordVisibility('current')}
                    >
                      <i className={`ki-duotone ${showPasswords.current ? 'ki-eye-slash' : 'ki-eye'} fs-2`}>
                        <span className="path1"></span>
                        <span className="path2"></span>
                        <span className="path3"></span>
                      </i>
                    </button>
                  </div>
                </div>

                {/* New Password */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">New Password</label>
                  <div className="position-relative">
                    <input 
                      type={showPasswords.new ? 'text' : 'password'}
                      className="form-control form-control-solid" 
                      placeholder="Enter new password"
                      name="newPassword"
                      value={formData.newPassword}
                      onChange={handleChange}
                      required
                    />
                    <button
                      type="button"
                      className="btn btn-icon btn-sm position-absolute end-0 top-50 translate-middle-y me-3"
                      onClick={() => togglePasswordVisibility('new')}
                    >
                      <i className={`ki-duotone ${showPasswords.new ? 'ki-eye-slash' : 'ki-eye'} fs-2`}>
                        <span className="path1"></span>
                        <span className="path2"></span>
                        <span className="path3"></span>
                      </i>
                    </button>
                  </div>
                  <div className="form-text">Password must be at least 6 characters long</div>
                </div>

                {/* Confirm Password */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Confirm New Password</label>
                  <div className="position-relative">
                    <input 
                      type={showPasswords.confirm ? 'text' : 'password'}
                      className="form-control form-control-solid" 
                      placeholder="Confirm new password"
                      name="confirmPassword"
                      value={formData.confirmPassword}
                      onChange={handleChange}
                      required
                    />
                    <button
                      type="button"
                      className="btn btn-icon btn-sm position-absolute end-0 top-50 translate-middle-y me-3"
                      onClick={() => togglePasswordVisibility('confirm')}
                    >
                      <i className={`ki-duotone ${showPasswords.confirm ? 'ki-eye-slash' : 'ki-eye'} fs-2`}>
                        <span className="path1"></span>
                        <span className="path2"></span>
                        <span className="path3"></span>
                      </i>
                    </button>
                  </div>
                </div>

                {/* Password Requirements */}
                <div className="notice d-flex bg-light-primary rounded border-primary border border-dashed p-6 mb-7">
                  <div className="d-flex flex-stack flex-grow-1">
                    <div className="fw-semibold">
                      <h4 className="text-gray-900 fw-bold">Password Requirements</h4>
                      <div className="fs-6 text-gray-700">
                        <ul className="mb-0">
                          <li>At least 6 characters long</li>
                          <li>Include uppercase and lowercase letters</li>
                          <li>Include at least one number</li>
                          <li>Include at least one special character</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Submit Buttons */}
                <div className="d-flex justify-content-between">
                  <button 
                    type="button" 
                    className="btn btn-light"
                    onClick={() => {
                      setFormData({
                        currentPassword: '',
                        newPassword: '',
                        confirmPassword: ''
                      });
                      setError('');
                      setSuccess('');
                    }}
                  >
                    Cancel
                  </button>

                  <button 
                    type="submit" 
                    className="btn btn-primary"
                    disabled={loading || !formData.currentPassword || !formData.newPassword || !formData.confirmPassword}
                  >
                    {loading ? (
                      <>
                        <span className="spinner-border spinner-border-sm align-middle me-3"></span>
                        Changing...
                      </>
                    ) : (
                      <>
                        <i className="ki-duotone ki-check fs-2 me-2"></i>
                        Change Password
                      </>
                    )}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div className="col-xl-6">
          {/* Security Tips */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Security Tips</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <div className="notice d-flex bg-light-warning rounded border-warning border border-dashed p-6 mb-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Keep Your Account Safe</h4>
                    <div className="fs-6 text-gray-700">
                      Follow these tips to keep your account secure
                    </div>
                  </div>
                </div>
              </div>

              <div className="mb-7">
                <h4 className="text-gray-900 fw-bold mb-3">Password Best Practices</h4>
                <ul className="text-gray-600">
                  <li className="mb-2">Use a unique password for this account</li>
                  <li className="mb-2">Don't share your password with anyone</li>
                  <li className="mb-2">Change your password regularly</li>
                  <li className="mb-2">Use a password manager</li>
                  <li className="mb-2">Avoid using personal information</li>
                </ul>
              </div>

              <div className="mb-7">
                <h4 className="text-gray-900 fw-bold mb-3">Additional Security</h4>
                <ul className="text-gray-600">
                  <li className="mb-2">Enable two-factor authentication</li>
                  <li className="mb-2">Keep your browser updated</li>
                  <li className="mb-2">Log out from shared devices</li>
                  <li className="mb-2">Monitor your account activity</li>
                </ul>
              </div>

              <div className="notice d-flex bg-light-info rounded border-info border border-dashed p-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Need Help?</h4>
                    <div className="fs-6 text-gray-700">
                      Contact support if you're having trouble accessing your account
                    </div>
                    <a href="mailto:support@recipeapp.com" className="text-primary mt-2">support@recipeapp.com</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </PageTemplate>
  );
};

export default ChangePasswordPage; 