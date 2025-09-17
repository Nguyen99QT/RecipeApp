'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface Review {
  _id: string;
  userId: {
    firstName: string;
    lastName: string;
    profileImage: string;
  };
  recipeId: {
    name: string;
    image: string;
  };
  rating: number;
  comment: string;
  isEnable: boolean;
  createdAt: string;
}

const ReviewPage = () => {
  const [reviews, setReviews] = useState<Review[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setReviews([
        {
          _id: '1',
          userId: {
            firstName: 'John',
            lastName: 'Doe',
            profileImage: '/assets/media/avatars/300-2.jpg'
          },
          recipeId: {
            name: 'Spaghetti Carbonara',
            image: '/assets/media/avatars/blank.png'
          },
          rating: 5,
          comment: 'Absolutely delicious! The recipe was easy to follow and the result was amazing.',
          isEnable: true,
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          userId: {
            firstName: 'Jane',
            lastName: 'Smith',
            profileImage: '/assets/media/avatars/300-2.jpg'
          },
          recipeId: {
            name: 'Chicken Fried Rice',
            image: '/assets/media/avatars/blank.png'
          },
          rating: 4,
          comment: 'Great recipe! Could use a bit more seasoning but overall very good.',
          isEnable: false,
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          userId: {
            firstName: 'Mike',
            lastName: 'Johnson',
            profileImage: '/assets/media/avatars/300-2.jpg'
          },
          recipeId: {
            name: 'Chocolate Cake',
            image: '/assets/media/avatars/blank.png'
          },
          rating: 3,
          comment: 'The cake was okay, but a bit too sweet for my taste.',
          isEnable: true,
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleToggleStatus = (id: string) => {
    setReviews(reviews.map(review => 
      review._id === id ? { ...review, isEnable: !review.isEnable } : review
    ));
  };

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this review?')) {
      setReviews(reviews.filter(review => review._id !== id));
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

  const renderStars = (rating: number) => {
    return Array.from({ length: 5 }, (_, index) => (
      <i 
        key={index}
        className={`fa fa-star ${index < rating ? 'text-warning' : 'text-muted'}`}
      ></i>
    ));
  };

  return (
    <PageTemplate
      title="Review Management"
      breadcrumbs={[{ label: 'Reviews' }]}
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
                placeholder="Search Reviews"
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
                    <th className="min-w-150px">Recipe</th>
                    <th className="min-w-100px">Rating</th>
                    <th className="min-w-200px">Comment</th>
                    <th className="min-w-100px">Status</th>
                    <th className="min-w-125px">Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {reviews.map((review) => (
                    <tr key={review._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-circle symbol-35px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={review.userId.profileImage} 
                              alt={`${review.userId.firstName} ${review.userId.lastName}`}
                              className="w-100"
                              width={35}
                              height={35}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {review.userId.firstName} {review.userId.lastName}
                          </span>
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-circle symbol-35px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={review.recipeId.image} 
                              alt={review.recipeId.name}
                              className="w-100"
                              width={35}
                              height={35}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {review.recipeId.name}
                          </span>
                        </div>
                      </td>
                      
                      <td>
                        <div className="d-flex align-items-center">
                          <div className="rating">
                            {renderStars(review.rating)}
                          </div>
                          <span className="text-muted fs-7 ms-2">({review.rating}/5)</span>
                        </div>
                      </td>
                      
                      <td>
                        <div className="text-gray-800 fs-6" style={{ maxWidth: '200px' }}>
                          {review.comment.length > 50 
                            ? `${review.comment.substring(0, 50)}...` 
                            : review.comment
                          }
                        </div>
                      </td>
                      
                      <td>
                        <span className={`badge ${review.isEnable ? 'badge-light-success' : 'badge-light-danger'} fw-bold fs-8 px-2 py-1`}>
                          {review.isEnable ? 'Approved' : 'Pending'}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(review.createdAt)}
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
                              href={`/review/view/${review._id}`} 
                              className="menu-link px-3"
                            >
                              View Details
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3"
                              onClick={() => handleToggleStatus(review._id)}
                            >
                              {review.isEnable ? 'Reject' : 'Approve'}
                            </button>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(review._id)}
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

export default ReviewPage; 