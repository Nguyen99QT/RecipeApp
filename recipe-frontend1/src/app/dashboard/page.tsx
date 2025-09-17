'use client';

import { useState, useEffect } from 'react';
import AdminLayout from '@/components/layout/AdminLayout';
import Link from 'next/link';

interface DashboardStats {
  totalCategory: number;
  totalCuisines: number;
  totalRecipe: number;
  totalUser: number;
  totalReview: number;
  totalFaq: number;
}

const DashboardPage = () => {
  const [stats, setStats] = useState<DashboardStats>({
    totalCategory: 0,
    totalCuisines: 0,
    totalRecipe: 0,
    totalUser: 0,
    totalReview: 0,
    totalFaq: 0
  });

  useEffect(() => {
    // Simulate loading dashboard stats
    // Replace with actual API call
    setStats({
      totalCategory: 15,
      totalCuisines: 25,
      totalRecipe: 150,
      totalUser: 1250,
      totalReview: 350,
      totalFaq: 20
    });
  }, []);

  return (
    <AdminLayout>
      {/* Toolbar */}
      <div id="kt_app_toolbar" className="app-toolbar pt-5">
        <div id="kt_app_toolbar_container" className="app-container container-fluid d-flex align-items-stretch">
          <div className="app-toolbar-wrapper d-flex flex-stack flex-wrap gap-4 w-100">
            {/* Page title */}
            <div className="page-title d-flex flex-column gap-1 me-3 mb-2">
              {/* Breadcrumb */}
              <ul className="breadcrumb breadcrumb-separatorless fw-semibold mb-6">
                <li className="breadcrumb-item text-gray-700 fw-bold lh-1">
                  <a href="#" className="text-gray-500">
                    <i className="ki-duotone ki-home fs-3 text-gray-400 me-n1"></i>
                  </a>
                </li>
                <li className="breadcrumb-item">
                  <i className="ki-duotone ki-right fs-4 text-gray-700 mx-n1"></i>
                </li>
                <li className="breadcrumb-item text-gray-700 fw-bold lh-1">Dashboards</li>
              </ul>
              
              {/* Title */}
              <h1 className="page-heading d-flex flex-column justify-content-center text-dark fw-bolder fs-1 lh-0 mt-1">
                Dashboard
              </h1>
            </div>
          </div>
        </div>
      </div>

      {/* Content */}
      <div id="kt_app_content" className="app-content flex-column-fluid">
        <div id="kt_app_content_container" className="app-container container-fluid">
          {/* Row */}
          <div className="row g-5 g-xl-10">
            
            {/* Category Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/category" className="card border-hover-primary">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-primary border border-gray d-flex justify-content-center align-items-center">
                      <i className="ki-solid ki-category fs-1 text-primary"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-primary fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">Category</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalCategory}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-primary rounded h-4px" style={{ width: '85%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total Categories</div>
                </div>
              </Link>
            </div>

            {/* Cuisines Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/cuisines" className="card border-hover-success">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-success border border-gray d-flex justify-content-center align-items-center">
                      <i className="fa-solid fa-utensils fs-1 text-success"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-success fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">Cuisines</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalCuisines}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-success rounded h-4px" style={{ width: '70%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total Cuisines</div>
                </div>
              </Link>
            </div>

            {/* Recipe Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/recipe" className="card border-hover-warning">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-warning border border-gray d-flex justify-content-center align-items-center">
                      <i className="ki-solid ki-book fs-1 text-warning"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-warning fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">Recipe</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalRecipe}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-warning rounded h-4px" style={{ width: '90%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total Recipes</div>
                </div>
              </Link>
            </div>

            {/* User Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/user" className="card border-hover-info">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-info border border-gray d-flex justify-content-center align-items-center">
                      <i className="ki-solid ki-profile-user fs-1 text-info"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-info fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">User</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalUser}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-info rounded h-4px" style={{ width: '75%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total Users</div>
                </div>
              </Link>
            </div>

            {/* Review Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/review" className="card border-hover-danger">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-danger border border-gray d-flex justify-content-center align-items-center">
                      <i className="ki-solid ki-star fs-1 text-danger"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-danger fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">Review</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalReview}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-danger rounded h-4px" style={{ width: '65%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total Reviews</div>
                </div>
              </Link>
            </div>

            {/* FAQ Card */}
            <div className="col-md-6 col-xl-4">
              <Link href="/faq" className="card border-hover-dark">
                <div className="card-header border-0 pt-9">
                  <div className="card-title">
                    <div className="symbol symbol-35px w-40px h-40px bg-light-dark border border-gray d-flex justify-content-center align-items-center">
                      <i className="ki-solid ki-questionnaire-tablet fs-1 text-dark"></i>
                    </div>
                  </div>
                  <div className="card-toolbar">
                    <span className="badge badge-light-dark fw-bold me-auto px-4 py-3">View More</span>
                  </div>
                </div>
                <div className="card-body p-9">
                  <div className="d-flex justify-content-between">
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">FAQ</div>
                    <div className="fs-3 fw-bold text-dark mt-1 mb-5">
                      {stats.totalFaq}
                    </div>
                  </div>
                  <div className="h-4px w-100 bg-light mb-5">
                    <div className="bg-dark rounded h-4px" style={{ width: '55%' }}></div>
                  </div>
                  <div className="fw-semibold text-gray-400">Total FAQs</div>
                </div>
              </Link>
            </div>

          </div>
        </div>
      </div>
    </AdminLayout>
  );
};

export default DashboardPage; 