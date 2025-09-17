'use client';

import { useState } from 'react';
import PageTemplate from '@/components/PageTemplate';

const PrivacyPolicyPage = () => {
  const [content, setContent] = useState(`
    <h3>Privacy Policy</h3>
    <p>This Privacy Policy describes how Recipe App collects, uses, and protects your personal information when you use our service.</p>
    
    <h4>1. Information We Collect</h4>
    <p>We collect information you provide directly to us, such as when you create an account, post recipes, or contact us for support.</p>
    
    <h4>2. How We Use Your Information</h4>
    <p>We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.</p>
    
    <h4>3. Information Sharing</h4>
    <p>We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.</p>
    
    <h4>4. Data Security</h4>
    <p>We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.</p>
    
    <h4>5. Cookies and Tracking</h4>
    <p>We use cookies and similar tracking technologies to enhance your experience on our platform and analyze usage patterns.</p>
    
    <h4>6. Data Retention</h4>
    <p>We retain your personal information for as long as necessary to provide our services and comply with legal obligations.</p>
    
    <h4>7. Your Rights</h4>
    <p>You have the right to access, update, or delete your personal information. You may also opt out of certain communications from us.</p>
    
    <h4>8. Contact Us</h4>
    <p>If you have any questions about this Privacy Policy, please contact us at privacy@recipeapp.com</p>
  `);
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
      setSuccess('Privacy Policy updated successfully!');
    } catch (err) {
      setError('Failed to update privacy policy. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <PageTemplate
      title="Privacy Policy"
      breadcrumbs={[{ label: 'Settings' }, { label: 'Privacy Policy' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-8">
          {/* Editor Card */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Edit Privacy Policy</h2>
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

                {/* Content Editor */}
                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Privacy Policy Content</label>
                  <textarea 
                    className="form-control form-control-solid" 
                    rows={20}
                    value={content}
                    onChange={(e) => setContent(e.target.value)}
                    required
                  />
                  <div className="form-text">Use HTML tags for formatting</div>
                </div>

                {/* Submit Button */}
                <div className="text-center">
                  <button 
                    type="submit" 
                    className="btn btn-primary"
                    disabled={loading}
                  >
                    {loading ? (
                      <>
                        <span className="spinner-border spinner-border-sm align-middle me-3"></span>
                        Updating...
                      </>
                    ) : (
                      <>
                        <i className="ki-duotone ki-check fs-2 me-2"></i>
                        Update Privacy Policy
                      </>
                    )}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div className="col-xl-4">
          {/* Preview Card */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Preview</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <div className="notice d-flex bg-light-primary rounded border-primary border border-dashed p-6 mb-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Live Preview</h4>
                    <div className="fs-6 text-gray-700">
                      This is how your privacy policy will appear to users
                    </div>
                  </div>
                </div>
              </div>

              {/* Content Preview */}
              <div 
                className="preview-content"
                style={{ 
                  maxHeight: '500px', 
                  overflowY: 'auto',
                  padding: '10px',
                  border: '1px solid #e4e6ef',
                  borderRadius: '6px',
                  backgroundColor: '#f8f9fa'
                }}
                dangerouslySetInnerHTML={{ __html: content }}
              />

              {/* Meta Information */}
              <div className="mt-6">
                <div className="fs-6 fw-bold text-gray-600 mb-3">Document Information</div>
                <div className="d-flex justify-content-between mb-2">
                  <span className="text-gray-600">Last Updated:</span>
                  <span className="fw-bold text-gray-800">{new Date().toLocaleDateString()}</span>
                </div>
                <div className="d-flex justify-content-between mb-2">
                  <span className="text-gray-600">Word Count:</span>
                  <span className="fw-bold text-gray-800">
                    {content.replace(/<[^>]*>/g, '').split(' ').length} words
                  </span>
                </div>
                <div className="d-flex justify-content-between">
                  <span className="text-gray-600">Status:</span>
                  <span className="badge badge-light-success">Published</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </PageTemplate>
  );
};

export default PrivacyPolicyPage; 