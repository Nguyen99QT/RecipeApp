'use client';

import { useState } from 'react';
import PageTemplate from '@/components/PageTemplate';

const SendNotificationPage = () => {
  const [formData, setFormData] = useState({
    title: '',
    message: '',
    targetAudience: 'all',
    scheduleType: 'now'
  });
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setSuccess('');

    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      setSuccess('Notification sent successfully!');
      setFormData({
        title: '',
        message: '',
        targetAudience: 'all',
        scheduleType: 'now'
      });
    } catch (err) {
      setError('Failed to send notification. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  return (
    <PageTemplate
      title="Send Notification"
      breadcrumbs={[{ label: 'Send Notification' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-6">
          {/* Notification Form */}
          <div className="card card-flush h-xl-100">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Send Push Notification</h2>
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

                {/* Title */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Notification Title</label>
                  <input 
                    type="text" 
                    className="form-control form-control-solid" 
                    placeholder="Enter notification title"
                    name="title"
                    value={formData.title}
                    onChange={handleChange}
                    required
                  />
                </div>

                {/* Message */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Message</label>
                  <textarea 
                    className="form-control form-control-solid" 
                    rows={4}
                    placeholder="Enter notification message"
                    name="message"
                    value={formData.message}
                    onChange={handleChange}
                    required
                  />
                  <div className="form-text">Maximum 160 characters</div>
                </div>

                {/* Target Audience */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Target Audience</label>
                  <select 
                    className="form-select form-select-solid"
                    name="targetAudience"
                    value={formData.targetAudience}
                    onChange={handleChange}
                  >
                    <option value="all">All Users</option>
                    <option value="active">Active Users Only</option>
                    <option value="premium">Premium Users</option>
                    <option value="recent">Recently Active</option>
                  </select>
                </div>

                {/* Schedule Type */}
                <div className="fv-row mb-7">
                  <label className="fs-6 fw-semibold mb-2">Schedule</label>
                  <div className="d-flex">
                    <div className="form-check form-check-custom form-check-solid me-10">
                      <input 
                        className="form-check-input h-20px w-20px" 
                        type="radio" 
                        name="scheduleType" 
                        value="now"
                        checked={formData.scheduleType === 'now'}
                        onChange={handleChange}
                        id="schedule_now"
                      />
                      <label className="form-check-label" htmlFor="schedule_now">
                        Send Now
                      </label>
                    </div>
                    <div className="form-check form-check-custom form-check-solid">
                      <input 
                        className="form-check-input h-20px w-20px" 
                        type="radio" 
                        name="scheduleType" 
                        value="later"
                        checked={formData.scheduleType === 'later'}
                        onChange={handleChange}
                        id="schedule_later"
                      />
                      <label className="form-check-label" htmlFor="schedule_later">
                        Schedule for Later
                      </label>
                    </div>
                  </div>
                </div>

                {/* Submit Button */}
                <div className="text-center">
                  <button 
                    type="submit" 
                    className="btn btn-primary"
                    disabled={loading || !formData.title || !formData.message}
                  >
                    {loading ? (
                      <>
                        <span className="spinner-border spinner-border-sm align-middle me-3"></span>
                        Sending...
                      </>
                    ) : (
                      <>
                        <i className="ki-duotone ki-notification-bing fs-2 me-2"></i>
                        Send Notification
                      </>
                    )}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div className="col-xl-6">
          {/* Preview Card */}
          <div className="card card-flush h-xl-100">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Notification Preview</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <div className="notice d-flex bg-light-primary rounded border-primary border border-dashed p-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Preview</h4>
                    <div className="fs-6 text-gray-700">
                      This is how your notification will appear to users
                    </div>
                  </div>
                </div>
              </div>

              {/* Mobile Preview */}
              <div className="d-flex justify-content-center mt-10">
                <div className="position-relative">
                  <div className="bg-gray-100 rounded-3 p-4" style={{ width: '300px' }}>
                    {/* Notification Preview */}
                    <div className="d-flex align-items-center mb-3">
                      <div className="symbol symbol-40px me-3">
                        <div className="symbol-label bg-primary">
                          <i className="ki-duotone ki-notification-bing text-white fs-2"></i>
                        </div>
                      </div>
                      <div className="flex-grow-1">
                        <div className="text-gray-900 fw-bold fs-6">
                          {formData.title || 'Notification Title'}
                        </div>
                        <div className="text-gray-600 fs-7">Recipe App</div>
                      </div>
                      <div className="text-gray-400 fs-8">now</div>
                    </div>
                    
                    <div className="text-gray-800 fs-6">
                      {formData.message || 'Your notification message will appear here...'}
                    </div>
                  </div>
                </div>
              </div>

              {/* Stats */}
              <div className="mt-10">
                <div className="fs-6 fw-bold text-gray-600 mb-3">Delivery Information</div>
                <div className="d-flex justify-content-between mb-2">
                  <span className="text-gray-600">Target Audience:</span>
                  <span className="fw-bold text-gray-800">
                    {formData.targetAudience === 'all' ? 'All Users' :
                     formData.targetAudience === 'active' ? 'Active Users' :
                     formData.targetAudience === 'premium' ? 'Premium Users' :
                     'Recently Active Users'}
                  </span>
                </div>
                <div className="d-flex justify-content-between mb-2">
                  <span className="text-gray-600">Estimated Recipients:</span>
                  <span className="fw-bold text-gray-800">1,250 users</span>
                </div>
                <div className="d-flex justify-content-between">
                  <span className="text-gray-600">Schedule:</span>
                  <span className="fw-bold text-gray-800">
                    {formData.scheduleType === 'now' ? 'Send Immediately' : 'Schedule for Later'}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </PageTemplate>
  );
};

export default SendNotificationPage; 