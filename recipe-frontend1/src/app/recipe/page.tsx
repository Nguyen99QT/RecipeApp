'use client';

import { useState, useEffect } from 'react';
import PageTemplate from '@/components/PageTemplate';
import Image from 'next/image';

interface Recipe {
  _id: string;
  name: string;
  image: string;
  categoryId: { name: string };
  cuisinesId: { name: string };
  difficultyLevel: string;
  prepTime: string;
  cookTime: string;
  servings: string;
  createdAt: string;
}

const RecipePage = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setRecipes([
        {
          _id: '1',
          name: 'Spaghetti Carbonara',
          image: '/assets/media/avatars/blank.png',
          categoryId: { name: 'Main Course' },
          cuisinesId: { name: 'Italian' },
          difficultyLevel: 'MEDIUM',
          prepTime: '15 mins',
          cookTime: '20 mins',
          servings: '4 people',
          createdAt: '2024-01-15T10:30:00Z'
        },
        {
          _id: '2',
          name: 'Chicken Fried Rice',
          image: '/assets/media/avatars/blank.png',
          categoryId: { name: 'Main Course' },
          cuisinesId: { name: 'Chinese' },
          difficultyLevel: 'EASY',
          prepTime: '10 mins',
          cookTime: '15 mins',
          servings: '3 people',
          createdAt: '2024-01-16T14:20:00Z'
        },
        {
          _id: '3',
          name: 'Chocolate Cake',
          image: '/assets/media/avatars/blank.png',
          categoryId: { name: 'Desserts' },
          cuisinesId: { name: 'American' },
          difficultyLevel: 'HARD',
          prepTime: '30 mins',
          cookTime: '45 mins',
          servings: '8 people',
          createdAt: '2024-01-17T09:15:00Z'
        }
      ]);
      setLoading(false);
    }, 1000);
  }, []);

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this recipe?')) {
      setRecipes(recipes.filter(recipe => recipe._id !== id));
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

  const getDifficultyBadge = (level: string) => {
    switch (level) {
      case 'EASY':
        return 'badge-light-success';
      case 'MEDIUM':
        return 'badge-light-warning';
      case 'HARD':
        return 'badge-light-danger';
      default:
        return 'badge-light-primary';
    }
  };

  return (
    <PageTemplate
      title="Recipe"
      breadcrumbs={[{ label: 'Recipe' }]}
      addButtonText="Add Recipe"
      addButtonHref="/recipe/add"
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
                placeholder="Search Recipe"
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
                    <th className="min-w-125px">Recipe</th>
                    <th className="min-w-100px">Category</th>
                    <th className="min-w-100px">Cuisine</th>
                    <th className="min-w-100px">Difficulty</th>
                    <th className="min-w-100px">Time</th>
                    <th className="min-w-100px">Servings</th>
                    <th className="min-w-125px">Created Date</th>
                    <th className="text-end min-w-100px">Actions</th>
                  </tr>
                </thead>
                <tbody className="text-gray-600 fw-semibold">
                  {recipes.map((recipe) => (
                    <tr key={recipe._id}>
                      <td>
                        <div className="form-check form-check-sm form-check-custom form-check-solid">
                          <input className="form-check-input" type="checkbox" />
                        </div>
                      </td>
                      
                      <td className="d-flex align-items-center">
                        <div className="symbol symbol-circle symbol-50px overflow-hidden me-3">
                          <div className="symbol-label">
                            <Image 
                              src={recipe.image} 
                              alt={recipe.name}
                              className="w-100"
                              width={50}
                              height={50}
                            />
                          </div>
                        </div>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold text-hover-primary fs-6">
                            {recipe.name}
                          </span>
                        </div>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {recipe.categoryId.name}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {recipe.cuisinesId.name}
                        </span>
                      </td>
                      
                      <td>
                        <span className={`badge ${getDifficultyBadge(recipe.difficultyLevel)} fw-bold fs-8 px-2 py-1`}>
                          {recipe.difficultyLevel}
                        </span>
                      </td>
                      
                      <td>
                        <div className="d-flex flex-column">
                          <span className="text-gray-800 fw-bold fs-7">Prep: {recipe.prepTime}</span>
                          <span className="text-gray-600 fs-7">Cook: {recipe.cookTime}</span>
                        </div>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold fs-6">
                          {recipe.servings}
                        </span>
                      </td>
                      
                      <td>
                        <span className="text-gray-800 fw-bold d-block fs-6">
                          {formatDate(recipe.createdAt)}
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
                              href={`/recipe/view/${recipe._id}`} 
                              className="menu-link px-3"
                            >
                              View
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <a 
                              href={`/recipe/edit/${recipe._id}`} 
                              className="menu-link px-3"
                            >
                              Edit
                            </a>
                          </div>
                          
                          <div className="menu-item px-3">
                            <button 
                              className="menu-link px-3 text-danger"
                              onClick={() => handleDelete(recipe._id)}
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

export default RecipePage; 