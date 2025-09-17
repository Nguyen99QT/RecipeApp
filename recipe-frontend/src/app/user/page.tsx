'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface User {
  _id: string;
  firstName: string;
  lastName: string;
  email: string;
  mobileNumber: string;
  profileImage: string;
  isEnable: boolean;
  createdAt: string;
}

const UserPage = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setUsers([
        {
          _id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          mobileNumber: '+1234567890',
          profileImage: '/assets/media/avatars/300-2.jpg',
          isEnable: true,
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane.smith@example.com',
          mobileNumber: '+1234567891',
          profileImage: '/assets/media/avatars/300-2.jpg',
          isEnable: false,
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          firstName: 'Mike',
          lastName: 'Johnson',
          email: 'mike.johnson@example.com',
          mobileNumber: '+1234567892',
          profileImage: '/assets/media/avatars/300-2.jpg',
          isEnable: true,
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleToggleStatus = (id: string) => {
    setUsers(users.map(user => 
      user._id === id ? { ...user, isEnable: !user.isEnable } : user
    ));
  };

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this user?')) {
      setUsers(users.filter(user => user._id !== id));
    }
  };

  const formatDate = (dateString: string) => {
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
      title="User Management"
      breadcrumbs={[{ label: 'Users' }]}
    >
      <div className="card">
        <div className="card-header border-0 pt-6">
          <div className="card-title">
            <div className="d-flex align-items-center position-relative my-1">
              <i className="ki-duotone ki-magnifier fs-3 position-absolute ms-5">
                <span className="path1"></span>
                <span className="path2"></span>
              </i>
              <input 
                type="text" 
                className="form-control form-control-solid w-250px ps-13" 
                placeholder="Search Users"
              />
            </div>
          </div>
          
          <div className="card-toolbar">
            <div className="d-flex justify-content-end">
              <button 
                type="button" 
                className="btn btn-light-primary me-3"
                onClick={() => window.location.reload()}
              >
                <i className="ki-duotone ki-arrows-circle fs-2">
                  <span className="path1"></span>
                  <span className="path2"></span>
                </i>
                Refresh
              </button>
            </div>
          </div>
        </div>
        
        <div className="card-body py-4">
          {loading ? (
            <div className="d-flex flex-center">
              <div className="spinner-border text-primary" role="status">
                <span className="visually-hidden">Loading...</span>
              </div>
            </div>
          ) : (
            <div className="table-responsive">
              <table className="table align-middle table-row-dashed fs-6 gy-5">
                <thead>
                  <tr className="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                    <th className="w-10px pe-2">
                      <div className="form-check form-check-sm form-check-custom form-check-solid me-3">
                        <input className="form-check-input" type="checkbox" />
                      </div>
                    </th>
                    <th className="min-w-150px">User</th>
                    <th className="min-w-125px">Email</th>
                    <th className="min-w-125px">Mobile</th>
                    <th className="min-w-100px">Status</th>
                    <th className="min-w-125px">Joined Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {users.map((user) => (
                    <tr key={user._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-circle symbol-50px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={user.profileImage} 
                              alt={`${user.firstName} ${user.lastName}`}
                              className="w-100"
                              width={50}
                              height={50}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {user.firstName} {user.lastName}
                          </span>
                          <span className="text-muted fs-7">User ID: {user._id}</span>
                        </div>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {user.email}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {user.mobileNumber}
                        </span>
                      </td>
                      
                      <td>
                        <span className={`badge ${user.isEnable ? 'badge-light-success' : 'badge-light-danger'} fw-bold fs-8 px-2 py-1`}>
                          {user.isEnable ? 'Active' : 'Inactive'}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(user.createdAt)}
                        </span>
                      </td>
                      
                      <td className="text-end">
                        <a 
                          href="#" 
                          className="btn btn-light btn-active-light-primary btn-flex btn-center btn-sm"
                          data-kt-menu-trigger="click" 
                          data-kt-menu-placement="bottom-end"
                        >
                          Actions
                          <i className="ki-duotone ki-down fs-5 ms-1"></i>
                        </a>
                        
                        <div className="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-150px py-4">
                          <div className="menu-item px-3">
                            <a 
                              href={`/user/view/${user._id}`} 
                              className="menu-link px-3"
                            >
                              View Details
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3"
                              onClick={() => handleToggleStatus(user._id)}
                            >
                              {user.isEnable ? 'Deactivate' : 'Activate'}
                            </button>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(user._id)}
                            >
                              Delete
                            </button>
                          </div>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </PageTemplate>
  );
};

export default UserPage; 