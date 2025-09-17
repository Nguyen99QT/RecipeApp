'use client';

import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

const ProfilePage = () => {
  // Mock admin data
  const adminData = {
    firstName: 'Admin',
    lastName: 'User',
    email: 'admin@recipe.com',
    mobileNumber: '+1234567890',
    profileImage: '/assets/media/avatars/300-2.jpg',
    role: 'Super Admin',
    joinedDate: '2023-01-01',
    lastLogin: '2024-01-18T10:30:00Z'
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: '2-digit'
    });
  };

  const formatDateTime = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <PageTemplate
      title="My Profile"
      breadcrumbs={[{ label: 'Profile' }]}
    >
      <div className="row g-5 g-xl-10">
        <div className="col-xl-4">
          {/* Profile Card */}
          <div className="card card-flush h-xl-100">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Profile Details</h2>
              </div>
              <div className="card-toolbar">
                <a href="/edit-profile" className="btn btn-sm btn-light-primary">
                  <i className="ki-duotone ki-pencil fs-3"></i>
                  Edit Profile
                </a>
              </div>
            </div>
            
            <div className="card-body pt-0">
              {/* Profile Image */}
              <div className="d-flex flex-center flex-column mb-5">
                <div className="symbol symbol-100px symbol-circle mb-7">
                  <Image 
                    src={adminData.profileImage}
                    alt="Profile"
                    width={100}
                    height={100}
                    className="rounded-circle"
                  />
                </div>
                
                <div className="fs-3 text-gray-800 text-hover-primary fw-bold mb-1">
                  {adminData.firstName} {adminData.lastName}
                </div>
                
                <div className="fs-5 fw-semibold text-muted mb-6">
                  {adminData.role}
                </div>
                
                <div className="d-flex flex-wrap fw-semibold fs-6 mb-4 pe-2">
                  <span className="d-flex align-items-center text-gray-400 text-hover-primary me-5 mb-2">
                    <i className="ki-duotone ki-profile-circle fs-4 me-1"></i>
                    {adminData.email}
                  </span>
                </div>
              </div>
              
              {/* Contact Information */}
              <div className="d-flex flex-stack fs-4 py-3">
                <div className="fw-bold rotate collapsible">
                  Contact Information
                </div>
              </div>
              
              <div className="separator separator-dashed my-3"></div>
              
              <div className="pb-5 fs-6">
                <div className="fw-bold text-gray-600">Email</div>
                <div className="text-gray-800">{adminData.email}</div>
              </div>
              
              <div className="pb-5 fs-6">
                <div className="fw-bold text-gray-600">Phone</div>
                <div className="text-gray-800">{adminData.mobileNumber}</div>
              </div>
              
              <div className="pb-5 fs-6">
                <div className="fw-bold text-gray-600">Role</div>
                <div className="text-gray-800">{adminData.role}</div>
              </div>
            </div>
          </div>
        </div>
        
        <div className="col-xl-8">
          {/* Account Information */}
          <div className="card card-flush h-xl-100">
            <div className="card-header border-0 pt-6">
              <div className="card-title">
                <h2 className="fw-bold m-0">Account Information</h2>
              </div>
            </div>
            
            <div className="card-body pt-0">
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Full Name</label>
                <div className="col-lg-8">
                  <span className="fw-bold fs-6 text-gray-800">
                    {adminData.firstName} {adminData.lastName}
                  </span>
                </div>
              </div>
              
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Email</label>
                <div className="col-lg-8 fv-row">
                  <span className="fw-semibold text-gray-800 fs-6">
                    {adminData.email}
                  </span>
                </div>
              </div>
              
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Mobile Number</label>
                <div className="col-lg-8 d-flex align-items-center">
                  <span className="fw-bold fs-6 text-gray-800 me-2">
                    {adminData.mobileNumber}
                  </span>
                  <span className="badge badge-success">Verified</span>
                </div>
              </div>
              
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Role</label>
                <div className="col-lg-8">
                  <span className="fw-bold fs-6 text-gray-800">
                    {adminData.role}
                  </span>
                </div>
              </div>
              
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Joined Date</label>
                <div className="col-lg-8">
                  <span className="fw-bold fs-6 text-gray-800">
                    {formatDate(adminData.joinedDate)}
                  </span>
                </div>
              </div>
              
              <div className="row mb-7">
                <label className="col-lg-4 fw-semibold text-muted">Last Login</label>
                <div className="col-lg-8">
                  <span className="fw-bold fs-6 text-gray-800">
                    {formatDateTime(adminData.lastLogin)}
                  </span>
                </div>
              </div>
              
              {/* Action Buttons */}
              <div className="d-flex my-4">
                <a href="/edit-profile" className="btn btn-primary me-3">
                  Edit Profile
                </a>
                <a href="/change-password" className="btn btn-light-primary">
                  Change Password
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </PageTemplate>
  );
};

export default ProfilePage; 