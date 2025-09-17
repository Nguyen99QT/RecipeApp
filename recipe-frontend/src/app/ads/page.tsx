'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface Ad {
  _id: string;
  title: string;
  description: string;
  image: string;
  link: string;
  position: string;
  isEnable: boolean;
  createdAt: string;
}

const AdsPage = () => {
  const [ads, setAds] = useState<Ad[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setAds([
        {
          _id: '1',
          title: 'Premium Kitchen Tools',
          description: 'Get the best kitchen tools for your cooking needs',
          image: '/assets/media/avatars/blank.png',
          link: 'https://example.com/kitchen-tools',
          position: 'Banner Top',
          isEnable: true,
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          title: 'Cooking Classes Online',
          description: 'Learn cooking from professional chefs',
          image: '/assets/media/avatars/blank.png',
          link: 'https://example.com/cooking-classes',
          position: 'Sidebar',
          isEnable: false,
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          title: 'Fresh Ingredients Delivery',
          description: 'Get fresh ingredients delivered to your door',
          image: '/assets/media/avatars/blank.png',
          link: 'https://example.com/delivery',
          position: 'Banner Bottom',
          isEnable: true,
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleToggleStatus = (id: string) => {
    setAds(ads.map(ad => 
      ad._id === id ? { ...ad, isEnable: !ad.isEnable } : ad
    ));
  };

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this ad?')) {
      setAds(ads.filter(ad => ad._id !== id));
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

  const getPositionBadge = (position: string) => {
    switch (position) {
      case 'Banner Top':
        return 'badge-light-primary';
      case 'Banner Bottom':
        return 'badge-light-success';
      case 'Sidebar':
        return 'badge-light-warning';
      default:
        return 'badge-light-secondary';
    }
  };

  return (
    <PageTemplate
      title="Ads Management"
      breadcrumbs={[{ label: 'Ads' }]}
      addButtonText="Add Ad"
      addButtonHref="/ads/add"
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
                placeholder="Search Ads"
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
                    <th className="min-w-200px">Ad Details</th>
                    <th className="min-w-100px">Position</th>
                    <th className="min-w-150px">Link</th>
                    <th className="min-w-100px">Status</th>
                    <th className="min-w-125px">Created Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {ads.map((ad) => (
                    <tr key={ad._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-50px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={ad.image} 
                              alt={ad.title}
                              className="w-100"
                              width={50}
                              height={50}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {ad.title}
                          </span>
                          <span className="text-muted fs-7">
                            {ad.description.length > 50 
                              ? `${ad.description.substring(0, 50)}...` 
                              : ad.description
                            }
                          </span>
                        </div>
                      </td>
                      
                      <td>
                        <span className={`badge ${getPositionBadge(ad.position)} fw-bold fs-8 px-2 py-1`}>
                          {ad.position}
                        </span>
                      </td>
                      
                      <td>
                        <a 
                          href={ad.link} 
                          target="_blank" 
                          rel="noopener noreferrer"
                          className="text-primary text-hover-primary fs-6"
                        >
                          {ad.link.length > 30 
                            ? `${ad.link.substring(0, 30)}...` 
                            : ad.link
                          }
                        </a>
                      </td>
                      
                      <td>
                        <span className={`badge ${ad.isEnable ? 'badge-light-success' : 'badge-light-danger'} fw-bold fs-8 px-2 py-1`}>
                          {ad.isEnable ? 'Active' : 'Inactive'}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(ad.createdAt)}
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
                        
                        <div className="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4">
                          <div className="menu-item px-3">
                            <a 
                              href={`/ads/view/${ad._id}`} 
                              className="menu-link px-3"
                            >
                              View
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <a 
                              href={`/ads/edit/${ad._id}`} 
                              className="menu-link px-3"
                            >
                              Edit
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3"
                              onClick={() => handleToggleStatus(ad._id)}
                            >
                              {ad.isEnable ? 'Deactivate' : 'Activate'}
                            </button>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(ad._id)}
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

export default AdsPage; 