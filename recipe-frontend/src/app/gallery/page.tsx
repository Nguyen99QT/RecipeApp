'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface GalleryItem {
  _id: string;
  title: string;
  image: string;
  type: 'image' | 'video';
  category: string;
  size: string;
  createdAt: string;
}

const GalleryPage = () => {
  const [gallery, setGallery] = useState<GalleryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');

  useEffect(() => {
    setTimeout(() => {
      setGallery([
        {
          _id: '1',
          title: 'Delicious Pasta',
          image: '/assets/media/avatars/blank.png',
          type: 'image',
          category: 'Recipe Photos',
          size: '2.5 MB',
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          title: 'Cooking Tutorial',
          image: '/assets/media/avatars/blank.png',
          type: 'video',
          category: 'Recipe Videos',
          size: '15.2 MB',
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          title: 'Fresh Ingredients',
          image: '/assets/media/avatars/blank.png',
          type: 'image',
          category: 'Ingredients',
          size: '1.8 MB',
          createdAt: '2024-01-17T09:15:00Z'
        },
        {
          _id: '4',
          title: 'Kitchen Setup',
          image: '/assets/media/avatars/blank.png',
          type: 'image',
          category: 'Kitchen',
          size: '3.2 MB',
          createdAt: '2024-01-18T11:45:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this item?')) {
      setGallery(gallery.filter(item => item._id !== id));
    }
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: '2-digit'
    });
  };

  const getTypeIcon = (type: string) => {
    return type === 'video' ? 'ki-duotone ki-video' : 'ki-duotone ki-picture';
  };

  const getTypeBadge = (type: string) => {
    return type === 'video' ? 'badge-light-danger' : 'badge-light-primary';
  };

  return (
    <PageTemplate
      title="Gallery Management"
      breadcrumbs={[{ label: 'Gallery' }]}
      addButtonText="Upload Media"
      addButtonHref="/gallery/upload"
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
                placeholder="Search Gallery"
              />
            </div>
          </div>
          
          <div className="card-toolbar">
            <div className="d-flex justify-content-end align-items-center">
              {/* View Mode Toggle */}
              <div className="btn-group me-3" role="group">
                <button 
                  type="button" 
                  className={`btn btn-sm ${viewMode === 'grid' ? 'btn-primary' : 'btn-light'}`}
                  onClick={() => setViewMode('grid')}
                >
                  <i className="ki-duotone ki-category fs-3"></i>
                </button>
                <button 
                  type="button" 
                  className={`btn btn-sm ${viewMode === 'list' ? 'btn-primary' : 'btn-light'}`}
                  onClick={() => setViewMode('list')}
                >
                  <i className="ki-duotone ki-row-horizontal fs-3"></i>
                </button>
              </div>

              <button 
                type="button" 
                className="btn btn-light-primary"
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
          ) : viewMode === 'grid' ? (
            /* Grid View */
            <div className="row g-6 g-xl-9">
              {gallery.map((item) => (
                <div key={item._id} className="col-md-6 col-lg-4 col-xl-3">
                  <div className="card card-flush h-xl-100">
                    <div className="card-header pt-5">
                      <div className="card-title d-flex flex-column">
                        <div className="symbol symbol-60px me-3">
                          <div className="symbol-label bg-light-primary">
                            <i className={`${getTypeIcon(item.type)} fs-2x text-primary`}></i>
                          </div>
                        </div>
                      </div>
                      
                      <div className="card-toolbar">
                        <span className={`badge ${getTypeBadge(item.type)} fw-bold fs-8 px-2 py-1`}>
                          {item.type.toUpperCase()}
                        </span>
                      </div>
                    </div>
                    
                    <div className="card-body pt-5">
                      <div className="fs-6 fw-bold text-gray-800 d-flex align-items-center mb-2">
                        {item.title}
                      </div>
                      
                      <div className="fs-7 fw-semibold text-gray-400 mb-6">
                        {item.category}
                      </div>
                      
                      <div className="d-flex flex-stack mb-3">
                        <div className="text-gray-600 fw-semibold fs-7">Size:</div>
                        <div className="text-gray-800 fw-bold fs-7">{item.size}</div>
                      </div>
                      
                      <div className="d-flex flex-stack mb-3">
                        <div className="text-gray-600 fw-semibold fs-7">Date:</div>
                        <div className="text-gray-800 fw-bold fs-7">{formatDate(item.createdAt)}</div>
                      </div>
                    </div>
                    
                    <div className="card-footer d-flex justify-content-end py-6 px-9">
                      <button 
                        className="btn btn-sm btn-light-primary me-2"
                        onClick={() => window.open('#', '_blank')}
                      >
                        View
                      </button>
                      <button 
                        className="btn btn-sm btn-light-danger"
                        onClick={() => handleDelete(item._id)}
                      >
                        Delete
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            /* List View */
            <div className="table-responsive">
              <table className="table align-middle table-row-dashed fs-6 gy-5">
                <thead>
                  <tr className="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                    <th className="w-10px pe-2">
                      <div className="form-check form-check-sm form-check-custom form-check-solid me-3">
                        <input className="form-check-input" type="checkbox" />
                      </div>
                    </th>
                    <th className="min-w-200px">File</th>
                    <th className="min-w-100px">Type</th>
                    <th className="min-w-125px">Category</th>
                    <th className="min-w-100px">Size</th>
                    <th className="min-w-125px">Upload Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {gallery.map((item) => (
                    <tr key={item._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-50px overflow-hidden me-3">
                          <div className="symbol-label bg-light-primary">
                            <i className={`${getTypeIcon(item.type)} fs-2x text-primary`}></i>
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {item.title}
                          </span>
                        </div>
                      </td>
                      
                      <td>
                        <span className={`badge ${getTypeBadge(item.type)} fw-bold fs-8 px-2 py-1`}>
                          {item.type.toUpperCase()}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {item.category}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {item.size}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(item.createdAt)}
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
                              href="#" 
                              className="menu-link px-3"
                              onClick={() => window.open('#', '_blank')}
                            >
                              View
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <a 
                              href="#" 
                              className="menu-link px-3"
                              onClick={() => navigator.clipboard.writeText('#')}
                            >
                              Copy Link
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(item._id)}
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

export default GalleryPage; 