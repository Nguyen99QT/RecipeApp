'use client';

import { ReactNode } from 'react';
import AdminLayout from '@/components/layout/AdminLayout';
import Link from 'next/link';

interface PageTemplateProps {
  title: string;
  breadcrumbs: { label: string; href?: string }[];
  children: ReactNode;
  addButtonText?: string;
  addButtonHref?: string;
}

const PageTemplate = ({ 
  title, 
  breadcrumbs, 
  children, 
  addButtonText, 
  addButtonHref 
}: PageTemplateProps) => {
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
                  <Link href="/dashboard" className="text-gray-500">
                    <i className="ki-duotone ki-home fs-3 text-gray-400 me-n1"></i>
                  </Link>
                </li>
                {breadcrumbs.map((crumb, index) => (
                  <div key={index} className="d-flex align-items-center">
                    <li className="breadcrumb-item">
                      <i className="ki-duotone ki-right fs-4 text-gray-700 mx-n1"></i>
                    </li>
                    <li className="breadcrumb-item text-gray-700 fw-bold lh-1">
                      {crumb.href ? (
                        <Link href={crumb.href}>{crumb.label}</Link>
                      ) : (
                        crumb.label
                      )}
                    </li>
                  </div>
                ))}
              </ul>
              
              {/* Title */}
              <h1 className="page-heading d-flex flex-column justify-content-center text-dark fw-bolder fs-1 lh-0 mt-1">
                {title}
              </h1>
            </div>
            
            {/* Add Button */}
            {addButtonText && addButtonHref && (
              <div className="d-flex align-items-center gap-2 gap-lg-3">
                <Link href={addButtonHref} className="btn btn-sm fw-bold btn-primary">
                  <i className="ki-duotone ki-plus fs-2"></i>
                  {addButtonText}
                </Link>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Content */}
      <div id="kt_app_content" className="app-content flex-column-fluid">
        <div id="kt_app_content_container" className="app-container container-fluid">
          {children}
        </div>
      </div>
    </AdminLayout>
  );
};

export default PageTemplate; 