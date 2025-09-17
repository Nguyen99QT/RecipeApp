'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface Category {
  _id: string;
  name: string;
  image: string;
  createdAt: string;
}

const CategoryPage = () => {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulate loading categories
    setTimeout(() => {
      setCategories([
        {
          _id: '1',
          name: 'Appetizers',
          image: '/assets/media/avatars/blank.png',
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          name: 'Main Course',
          image: '/assets/media/avatars/blank.png',
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          name: 'Desserts',
          image: '/assets/media/avatars/blank.png',
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this category?')) {
      setCategories(categories.filter(cat => cat._id !== id));
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
      title="Category"
      breadcrumbs={[{ label: 'Category' }]}
      addButtonText="Add Category"
      addButtonHref="/category/add"
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
                placeholder="Search Category"
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
                    <th className="min-w-125px">Category</th>
                    <th className="min-w-125px">Image</th>
                    <th className="min-w-125px">Created Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {categories.map((category) => (
                    <tr key={category._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                          {category.name}
                        </span>
                      </td>
                      
                      <td>
                        <div className="symbol symbol-circle symbol-50px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={category.image} 
                              alt={category.name}
                              className="w-100"
                              width={50}
                              height={50}
                            />
                          </div>
                        </div>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(category.createdAt)}
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
                              href={`/category/edit/${category._id}`} 
                              className="menu-link px-3"
                            >
                              Edit
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(category._id)}
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
              
              {categories.length === 0 && (
                <div className="d-flex flex-center">
                  <div className="text-center">
                    <Image 
                      src="/assets/media/svg/blank-image.svg"
                      alt="No data"
                      width={200}
                      height={200}
                    />
                    <p className="text-gray-600 fs-6 mt-5">No categories found</p>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </PageTemplate>
  );
};

export default CategoryPage; 