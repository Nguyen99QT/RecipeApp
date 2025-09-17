'use client';

import { ReactNode } from 'react';
import Sidebar from './Sidebar';
import Navbar from './Navbar';
import Footer from './Footer';
import ScriptLoader from '../ScriptLoader';

interface AdminLayoutProps {
  children: ReactNode;
}

const AdminLayout = ({ children }: AdminLayoutProps) => {
  return (
    <div className="d-flex flex-column flex-root app-root" id="kt_app_root">
      <ScriptLoader />
      <div className="app-page flex-column flex-column-fluid" id="kt_app_page">
        {/* Header */}
        <div id="kt_app_header" className="app-header d-flex flex-column flex-stack">
          <Navbar />
          <div className="app-header-separator"></div>
        </div>
        
        {/* Wrapper */}
        <div className="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
          {/* Sidebar */}
          <div 
            id="kt_app_sidebar" 
            className="app-sidebar flex-column" 
            data-kt-drawer="true" 
            data-kt-drawer-name="app-sidebar" 
            data-kt-drawer-activate="{default: true, lg: false}" 
            data-kt-drawer-overlay="true" 
            data-kt-drawer-width="250px" 
            data-kt-drawer-direction="start" 
            data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle"
          >
            <Sidebar />
          </div>
          
          {/* Main */}
          <div className="app-main flex-column flex-row-fluid" id="kt_app_main">
            <div className="d-flex flex-column flex-column-fluid">
              {children}
            </div>
            
            {/* Footer */}
            <Footer />
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminLayout; 