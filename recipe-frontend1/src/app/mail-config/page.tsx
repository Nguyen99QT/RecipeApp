'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';

interface MailConfig {
  host: string;
  port: string;
  mail_username: string;
  mail_password: string;
  encryption: string;
  senderEmail: string;
  senderName: string;
}

const MailConfigPage = () => {
  const [formData, setFormData] = useState<MailConfig>({
    host: '',
    port: '',
    mail_username: '',
    mail_password: '',
    encryption: 'tls',
    senderEmail: '',
    senderName: ''
  });
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');
  const [testLoading, setTestLoading] = useState(false);

  useEffect(() => {
    // Load existing config
    setFormData({
      host: 'smtp.gmail.com',
      port: '587',
      mail_username: 'admin@recipe.com',
      mail_password: '••••••••••••',
      encryption: 'tls',
      senderEmail: 'admin@recipe.com',
      senderName: 'Recipe Admin'
    });
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setSuccess('');

    try {
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      setSuccess('Mail configuration saved successfully!');
    } catch (err) {
      setError('Failed to save configuration. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleTestEmail = async () => {
    setTestLoading(true);
    setError('');
    setSuccess('');

    try {
      await new Promise(resolve => setTimeout(resolve, 3000));
      setSuccess('Test email sent successfully! Please check your inbox.');
    } catch (err) {
      setError('Failed to send test email. Please check your configuration.');
    } finally {
      setTestLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  return (
    <PageTemplate
      title="Mail Configuration"
      breadcrumbs={[{ label: 'Settings' }, { label: 'Mail Config' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-8">
          {/* SMTP Configuration */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">SMTP Settings</h2>
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

                <div className="row mb-7">
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">SMTP Host</label>
                    <input 
                      type="text" 
                      className="form-control form-control-solid" 
                      placeholder="smtp.gmail.com"
                      name="host"
                      value={formData.host}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">SMTP Port</label>
                    <input 
                      type="text" 
                      className="form-control form-control-solid" 
                      placeholder="587"
                      name="port"
                      value={formData.port}
                      onChange={handleChange}
                      required
                    />
                  </div>
                </div>

                <div className="row mb-7">
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">Username</label>
                    <input 
                      type="email" 
                      className="form-control form-control-solid" 
                      placeholder="your-email@gmail.com"
                      name="mail_username"
                      value={formData.mail_username}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">Password</label>
                    <input 
                      type="password" 
                      className="form-control form-control-solid" 
                      placeholder="Enter password"
                      name="mail_password"
                      value={formData.mail_password}
                      onChange={handleChange}
                      required
                    />
                  </div>
                </div>

                <div className="row mb-7">
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">Encryption</label>
                    <select 
                      className="form-select form-select-solid"
                      name="encryption"
                      value={formData.encryption}
                      onChange={handleChange}
                    >
                      <option value="tls">TLS</option>
                      <option value="ssl">SSL</option>
                      <option value="none">None</option>
                    </select>
                  </div>
                  <div className="col-md-6 fv-row">
                    <label className="required fs-6 fw-semibold mb-2">Sender Email</label>
                    <input 
                      type="email" 
                      className="form-control form-control-solid" 
                      placeholder="noreply@recipe.com"
                      name="senderEmail"
                      value={formData.senderEmail}
                      onChange={handleChange}
                      required
                    />
                  </div>
                </div>

                <div className="fv-row mb-7">
                  <label className="required fs-6 fw-semibold mb-2">Sender Name</label>
                  <input 
                    type="text" 
                    className="form-control form-control-solid" 
                    placeholder="Recipe Admin"
                    name="senderName"
                    value={formData.senderName}
                    onChange={handleChange}
                    required
                  />
                </div>

                <div className="d-flex justify-content-between">
                  <button 
                    type="button" 
                    className="btn btn-light-primary"
                    onClick={handleTestEmail}
                    disabled={testLoading}
                  >
                    {testLoading ? (
                      <>
                        <span className="spinner-border spinner-border-sm align-middle me-3"></span>
                        Testing...
                      </>
                    ) : (
                      <>
                        <i className="ki-duotone ki-message-text fs-2 me-2"></i>
                        Send Test Email
                      </>
                    )}
                  </button>

                  <button 
                    type="submit" 
                    className="btn btn-primary"
                    disabled={loading}
                  >
                    {loading ? (
                      <>
                        <span className="spinner-border spinner-border-sm align-middle me-3"></span>
                        Saving...
                      </>
                    ) : (
                      <>
                        <i className="ki-duotone ki-check fs-2 me-2"></i>
                        Save Configuration
                      </>
                    )}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div className="col-xl-4">
          {/* Configuration Guide */}
          <div className="card card-flush">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Configuration Guide</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <div className="notice d-flex bg-light-primary rounded border-primary border border-dashed p-6 mb-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Gmail Setup</h4>
                    <div className="fs-6 text-gray-700">
                      Use App Password for Gmail accounts with 2FA enabled
                    </div>
                  </div>
                </div>
              </div>

              <div className="mb-7">
                <h4 className="text-gray-900 fw-bold mb-3">Common SMTP Settings</h4>
                
                <div className="mb-4">
                  <strong>Gmail:</strong>
                  <ul className="text-gray-600 mt-2">
                    <li>Host: smtp.gmail.com</li>
                    <li>Port: 587 (TLS) or 465 (SSL)</li>
                    <li>Encryption: TLS</li>
                  </ul>
                </div>

                <div className="mb-4">
                  <strong>Outlook:</strong>
                  <ul className="text-gray-600 mt-2">
                    <li>Host: smtp-mail.outlook.com</li>
                    <li>Port: 587</li>
                    <li>Encryption: TLS</li>
                  </ul>
                </div>

                <div className="mb-4">
                  <strong>Yahoo:</strong>
                  <ul className="text-gray-600 mt-2">
                    <li>Host: smtp.mail.yahoo.com</li>
                    <li>Port: 587 or 465</li>
                    <li>Encryption: TLS/SSL</li>
                  </ul>
                </div>
              </div>

              <div className="notice d-flex bg-light-warning rounded border-warning border border-dashed p-6">
                <div className="d-flex flex-stack flex-grow-1">
                  <div className="fw-semibold">
                    <h4 className="text-gray-900 fw-bold">Security Note</h4>
                    <div className="fs-6 text-gray-700">
                      Always use App Passwords instead of account passwords for better security
                    </div>
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

export default MailConfigPage; 