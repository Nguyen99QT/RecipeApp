'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

const Sidebar = () => {
  const pathname = usePathname();

  const isActive = (path: string) => pathname === path;

  return (
    <div 
      className="d-flex flex-column justify-content-between h-100 hover-scroll-overlay-y my-2 d-flex flex-column" 
      id="kt_app_sidebar_main" 
      data-kt-scroll="true" 
      data-kt-scroll-activate="true" 
      data-kt-scroll-height="auto" 
      data-kt-scroll-dependencies="#kt_app_header" 
      data-kt-scroll-wrappers="#kt_app_main" 
      data-kt-scroll-offset="5px"
    >
      {/* Sidebar menu */}
      <div 
        id="#kt_app_sidebar_menu" 
        data-kt-menu="true" 
        data-kt-menu-expand="false" 
        className="flex-column-fluid menu menu-sub-indention menu-column menu-rounded menu-active-bg mb-7"
      >
        {/* Dashboard */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className={`menu-item ${isActive('/dashboard') ? 'active' : ''}`}>
            <Link 
              className="menu-link" 
              href="/dashboard" 
              title="Dashboard" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="fa-solid fa-house fs-2"></i>
              </span>
              <span className="menu-title">Dashboard</span>
            </Link>
          </div>
        </div>

        {/* Intro */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-notepad-edit fs-1"></i>
            </span>
            <span className="menu-title">Intro</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/intro" 
                title="View All Intro" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">View All Intro</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Category */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-category fs-1"></i>
            </span>
            <span className="menu-title">Category</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/category" 
                title="View All Category" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">View All Category</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Cuisines */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="fa-solid fa-utensils fs-1"></i>
            </span>
            <span className="menu-title">Cuisines</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/cuisines" 
                title="View All Cuisines" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">View All Cuisines</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Recipe */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-book fs-1"></i>
            </span>
            <span className="menu-title">Recipe</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/recipe" 
                title="View All Recipe" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">View All Recipe</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/recipe/add" 
                title="Add Recipe" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Add Recipe</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Review */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className="menu-item">
            <Link 
              className="menu-link" 
              href="/review" 
              title="Review" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="ki-solid ki-star fs-1"></i>
              </span>
              <span className="menu-title">Review</span>
            </Link>
          </div>
        </div>

        {/* User */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className="menu-item">
            <Link 
              className="menu-link" 
              href="/user" 
              title="User" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="ki-solid ki-profile-user fs-1"></i>
              </span>
              <span className="menu-title">User</span>
            </Link>
          </div>
        </div>

        {/* Ads */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className="menu-item">
            <Link 
              className="menu-link" 
              href="/ads" 
              title="Ads" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="ki-solid ki-notification-status fs-1"></i>
              </span>
              <span className="menu-title">Ads</span>
            </Link>
          </div>
        </div>

        {/* FAQ */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-questionnaire-tablet fs-1"></i>
            </span>
            <span className="menu-title">FAQ</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/faq" 
                title="View All FAQ" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">View All FAQ</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/faq/add" 
                title="Add FAQ" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Add FAQ</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Gallery */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className="menu-item">
            <Link 
              className="menu-link" 
              href="/gallery" 
              title="Gallery" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="ki-solid ki-picture fs-1"></i>
              </span>
              <span className="menu-title">Gallery</span>
            </Link>
          </div>
        </div>

        {/* Send Notification */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <div className="menu-item">
            <Link 
              className="menu-link" 
              href="/send-notification" 
              title="Send Notification" 
              data-bs-toggle="tooltip" 
              data-bs-trigger="hover" 
              data-bs-dismiss="click" 
              data-bs-placement="right"
            >
              <span className="menu-icon">
                <i className="ki-solid ki-notification-bing fs-1"></i>
              </span>
              <span className="menu-title">Send Notification</span>
            </Link>
          </div>
        </div>

        {/* Setting */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-setting-2 fs-1"></i>
            </span>
            <span className="menu-title">Setting</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/mail-config" 
                title="Mail Config" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Mail Config</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/terms-conditions" 
                title="Terms & Conditions" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Terms & Conditions</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/privacy-policy" 
                title="Privacy Policy" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Privacy Policy</span>
              </Link>
            </div>
          </div>
        </div>

        {/* Profile */}
        <div data-kt-menu-trigger="click" className="menu-item menu-accordion">
          <span className="menu-link">
            <span className="menu-icon">
              <i className="ki-solid ki-profile-circle fs-1"></i>
            </span>
            <span className="menu-title">Profile</span>
            <span className="menu-arrow"></span>
          </span>
          <div className="menu-sub menu-sub-accordion">
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/profile" 
                title="Profile" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Profile</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/edit-profile" 
                title="Edit Profile" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Edit Profile</span>
              </Link>
            </div>
            <div className="menu-item">
              <Link 
                className="menu-link" 
                href="/change-password" 
                title="Change Password" 
                data-bs-toggle="tooltip" 
                data-bs-trigger="hover" 
                data-bs-dismiss="click" 
                data-bs-placement="right"
              >
                <span className="menu-bullet">
                  <span className="bullet bullet-dot"></span>
                </span>
                <span className="menu-title">Change Password</span>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Sidebar; 