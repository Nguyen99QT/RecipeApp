'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface Intro {
  _id: string;
  title: string;
  description: string;
  image: string;
  order: number;
  isEnable: boolean;
  createdAt: string;
}

const IntroPage = () => {
  const [intros, setIntros] = useState<Intro[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setIntros([
        {
          _id: '1',
          title: 'Welcome to Recipe App',
          description: 'Discover thousands of delicious recipes from around the world',
          image: '/assets/media/avatars/blank.png',
          order: 1,
          isEnable: true,
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          title: 'Cook Like a Pro',
          description: 'Learn from professional chefs with step-by-step instructions',
          image: '/assets/media/avatars/blank.png',
          order: 2,
          isEnable: true,
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          title: 'Share Your Recipes',
          description: 'Share your favorite recipes with the cooking community',
          image: '/assets/media/avatars/blank.png',
          order: 3,
          isEnable: false,
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleToggleStatus = (id: string) => {
    setIntros(intros.map(intro => 
      intro._id === id ? { ...intro, isEnable: !intro.isEnable } : intro
    ));
  };

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this intro?')) {
      setIntros(intros.filter(intro => intro._id !== id));
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

  const moveUp = (id: string) => {
    const currentIndex = intros.findIndex(intro => intro._id === id);
    if (currentIndex > 0) {
      const newIntros = [...intros];
      [newIntros[currentIndex], newIntros[currentIndex - 1]] = [newIntros[currentIndex - 1], newIntros[currentIndex]];
      // Update order numbers
      newIntros[currentIndex].order = currentIndex + 1;
      newIntros[currentIndex - 1].order = currentIndex;
      setIntros(newIntros);
    }
  };

  const moveDown = (id: string) => {
    const currentIndex = intros.findIndex(intro => intro._id === id);
    if (currentIndex < intros.length - 1) {
      const newIntros = [...intros];
      [newIntros[currentIndex], newIntros[currentIndex + 1]] = [newIntros[currentIndex + 1], newIntros[currentIndex]];
      // Update order numbers
      newIntros[currentIndex].order = currentIndex + 1;
      newIntros[currentIndex + 1].order = currentIndex + 2;
      setIntros(newIntros);
    }
  };

  return (
    <PageTemplate
      title="Intro Management"
      breadcrumbs={[{ label: 'Intro' }]}
      addButtonText="Add Intro"
      addButtonHref="/intro/add"
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
                placeholder="Search Intro"
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
                    <th className="min-w-50px">Order</th>
                    <th className="min-w-250px">Intro Details</th>
                    <th className="min-w-100px">Status</th>
                    <th className="min-w-125px">Created Date</th>
                    <th className="text-end min-w-150px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {intros.map((intro, index) => (
                    <tr key={intro._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td>
                        <div className="d-flex flex-column align-items-center">
                          <span className="badge badge-light-primary fw-bold fs-7 px-2 py-1 mb-2">
                            #{intro.order}
                          </span>
                          <div className="d-flex">
                            <button 
                              className="btn btn-icon btn-light btn-sm me-1"
                              onClick={() => moveUp(intro._id)}
                              disabled={index === 0}
                            >
                              <i className="ki-duotone ki-up fs-7"></i>
                            </button>
                            <button 
                              className="btn btn-icon btn-light btn-sm"
                              onClick={() => moveDown(intro._id)}
                              disabled={index === intros.length - 1}
                            >
                              <i className="ki-duotone ki-down fs-7"></i>
                            </button>
                          </div>
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-60px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={intro.image} 
                              alt={intro.title}
                              className="w-100"
                              width={60}
                              height={60}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6 mb-1">
                            {intro.title}
                          </span>
                          <span className="text-muted fs-7">
                            {intro.description.length > 60 
                              ? `${intro.description.substring(0, 60)}...` 
                              : intro.description
                            }
                          </span>
                        </div>
                      </td>
                      
                      <td>
                        <span className={`badge ${intro.isEnable ? 'badge-light-success' : 'badge-light-danger'} fw-bold fs-8 px-2 py-1`}>
                          {intro.isEnable ? 'Active' : 'Inactive'}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(intro.createdAt)}
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
                              href={`/intro/view/${intro._id}`} 
                              className="menu-link px-3"
                            >
                              View Details
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <a 
                              href={`/intro/edit/${intro._id}`} 
                              className="menu-link px-3"
                            >
                              Edit
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3"
                              onClick={() => handleToggleStatus(intro._id)}
                            >
                              {intro.isEnable ? 'Deactivate' : 'Activate'}
                            </button>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(intro._id)}
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

export default IntroPage; 