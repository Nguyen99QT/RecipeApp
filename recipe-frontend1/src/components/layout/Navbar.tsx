'use client';

import Image from 'next/image';
import Link from 'next/link';

const Navbar = () => {
  return (
    <div className="d-flex align-items-center flex-stack flex-grow-1">
      <div className="app-header-logo d-flex align-items-center flex-stack px-lg-11 mb-2" id="kt_app_header_logo">
        {/* Sidebar mobile toggle */}
        <div className="btn btn-icon btn-active-color-primary w-35px h-35px ms-3 me-2 d-flex d-lg-none" id="kt_app_sidebar_mobile_toggle">
          <i className="ki-duotone ki-abstract-14 fs-2">
            <span className="path1"></span>
            <span className="path2"></span>
          </i>
        </div>
        
        {/* Logo */}
        <Link href="/dashboard" className="app-sidebar-logo mt-5 d-flex align-items-center">
          <Image 
            alt="Logo" 
            src="/assets/media/illustrations/sigma-1/logo.png" 
            className="h-35px theme-light-show" 
            width={35}
            height={35}
          />
          <div className="fw-bolder text-orange fs-1 ms-2">Recipe</div>
        </Link>
        
        {/* Sidebar toggle */}
        <div 
          id="kt_app_sidebar_toggle" 
          className="app-sidebar-toggle btn btn-sm btn-icon btn-color-warning me-n2 d-none d-lg-flex mt-5" 
          data-kt-toggle="true" 
          data-kt-toggle-state="active" 
          data-kt-toggle-target="body" 
          data-kt-toggle-name="app-sidebar-minimize"
        >
          <i className="ki-duotone ki-exit-left fs-2x rotate-180">
            <span className="path1"></span>
            <span className="path2"></span>
          </i>
        </div>
      </div>

      {/* Navbar */}
      <div className="app-navbar flex-grow-1 justify-content-end" id="kt_app_header_navbar">
        <div className="app-navbar-item d-flex align-items-stretch flex-lg-grow-1 me-2 me-lg-0">
          {/* Search */}
          <div 
            id="kt_header_search" 
            className="header-search d-flex align-items-center w-lg-350px" 
            data-kt-search-keypress="true" 
            data-kt-search-min-length="2" 
            data-kt-search-enter="enter" 
            data-kt-search-layout="menu" 
            data-kt-search-responsive="true" 
            data-kt-menu-trigger="auto" 
            data-kt-menu-permanent="true" 
            data-kt-menu-placement="bottom-start"
          >
            {/* Tablet and mobile search toggle */}
            <div data-kt-search-element="toggle" className="search-toggle-mobile d-flex d-lg-none align-items-center">
              <div className="d-flex">
                <i className="ki-duotone ki-magnifier fs-1 fs-1">
                  <span className="path1"></span>
                  <span className="path2"></span>
                </i>
              </div>
            </div>
            
            {/* Form */}
            <form 
              data-kt-search-element="form" 
              className="d-none d-lg-block w-100 position-relative mb-5 mb-lg-0" 
              autoComplete="off"
            >
              <input type="hidden" />
              <i className="ki-duotone ki-magnifier search-icon fs-2 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
                <span className="path1"></span>
                <span className="path2"></span>
              </i>
              <input 
                type="text" 
                className="form-control form-control-lg form-control-solid px-15" 
                name="search" 
                placeholder="Search by keywords" 
                data-kt-search-element="input" 
              />
              <span 
                className="position-absolute top-50 end-0 translate-middle-y lh-0 d-none me-5" 
                data-kt-search-element="spinner"
              >
                <span className="spinner-border h-15px w-15px align-middle text-gray-400"></span>
              </span>
              <span 
                className="btn btn-flush btn-active-color-primary position-absolute top-50 end-0 translate-middle-y lh-0 me-4 d-none" 
                data-kt-search-element="clear"
              >
                <i className="ki-duotone ki-cross fs-2 fs-lg-1 me-0">
                  <span className="path1"></span>
                  <span className="path2"></span>
                </i>
              </span>
            </form>
          </div>
        </div>
        
        {/* User menu */}
        <div className="app-navbar-item ms-3" id="kt_header_user_menu_toggle">
          <div 
            className="cursor-pointer symbol symbol-35px symbol-lg-35px" 
            data-kt-menu-trigger="{default: 'click', lg: 'hover'}" 
            data-kt-menu-attach="parent" 
            data-kt-menu-placement="bottom-end"
          >
            <Image 
              alt="Profile" 
              src="/assets/media/avatars/300-2.jpg" 
              className="rounded-3" 
              width={35}
              height={35}
            />
          </div>
          
          {/* User account menu */}
          <div 
            className="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px" 
            data-kt-menu="true"
          >
            {/* Menu item */}
            <div className="menu-item px-3">
              <div className="menu-content d-flex align-items-center px-3">
                <div className="symbol symbol-50px me-5">
                  <Image 
                    alt="Profile" 
                    src="/assets/media/avatars/300-2.jpg" 
                    width={50}
                    height={50}
                  />
                </div>
                <div className="d-flex flex-column">
                  <div className="fw-bold d-flex align-items-center fs-5">
                    Admin User
                    <span className="badge badge-light-success fw-bold fs-8 px-2 py-1 ms-2">Pro</span>
                  </div>
                  <span className="fw-semibold text-muted text-hover-primary fs-7">admin@recipe.com</span>
                </div>
              </div>
            </div>
            
            {/* Menu separator */}
            <div className="separator my-2"></div>
            
            {/* Menu item */}
            <div className="menu-item px-5">
              <Link href="/profile" className="menu-link px-5">My Profile</Link>
            </div>
            
            <div className="menu-item px-5">
              <Link href="/edit-profile" className="menu-link px-5">Edit Profile</Link>
            </div>
            
            <div className="menu-item px-5">
              <Link href="/change-password" className="menu-link px-5">Change Password</Link>
            </div>
            
            {/* Menu separator */}
            <div className="separator my-2"></div>
            
            {/* Menu item */}
            <div className="menu-item px-5 my-1">
              <Link href="/mail-config" className="menu-link px-5">Mail Settings</Link>
            </div>
            
            <div className="menu-item px-5">
              <button className="menu-link px-5" onClick={() => {
                // Handle logout
                localStorage.clear();
                window.location.href = '/login';
              }}>
                Sign Out
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Navbar; 