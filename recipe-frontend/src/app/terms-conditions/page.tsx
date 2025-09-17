'use client';

import { useState } from 'react';
import PageTemplate from '@/components/PageTemplate';

const TermsConditionsPage = () => {
  const [content, setContent] = useState(`
    <h3>Terms and Conditions</h3>
    <p>Welcome to Recipe App. These terms and conditions outline the rules and regulations for the use of Recipe App's Website.</p>
    
    <h4>1. Acceptance of Terms</h4>
    <p>By accessing and using this website, we assume you accept these terms and conditions. Do not continue to use Recipe App if you do not agree to take all of the terms and conditions stated on this page.</p>
    
    <h4>2. Use License</h4>
    <p>Permission is granted to temporarily download one copy of the materials (information or software) on Recipe App's website for personal, non-commercial transitory viewing only.</p>
    
    <h4>3. User Accounts</h4>
    <p>When you create an account with us, you must provide information that is accurate, complete, and current at all times.</p>
    
    <h4>4. Content Guidelines</h4>
    <p>Users may post, upload, or otherwise contribute content to the service. You are responsible for the content that you post to the service.</p>
    
    <h4>5. Privacy Policy</h4>
    <p>Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the Service.</p>
    
    <h4>6. Termination</h4>
    <p>We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever.</p>
    
    <h4>7. Contact Information</h4>
    <p>If you have any questions about these Terms and Conditions, please contact us at legal@recipeapp.com</p>
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
      setSuccess('Terms and Conditions updated successfully!');
    } catch (err) {
      setError('Failed to update terms and conditions. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <PageTemplate
      title="Terms & Conditions"
      breadcrumbs={[{ label: 'Settings' }, { label: 'Terms & Conditions' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-8">
          {/* Editor Card */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Edit Terms & Conditions</h2>
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
                  <label className="required fs-6 fw-semibold mb-2">Terms & Conditions Content</label>
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
                        Update Terms & Conditions
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
                      This is how your terms will appear to users
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

export default TermsConditionsPage; 