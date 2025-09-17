const Footer = () => {
  return (
    <div id="kt_app_footer" className="app-footer d-flex flex-column flex-md-row flex-center flex-md-stack">
      {/* Text */}
      <div className="text-dark order-2 order-md-1">
        <span className="text-muted fw-semibold me-1">© {new Date().getFullYear()}</span>
        <span className="text-gray-800 text-hover-primary">Recipe Admin Panel</span>
      </div>
      
      {/* Menu */}
      <ul className="menu menu-gray-600 menu-hover-primary fw-semibold order-1">
        <li className="menu-item">
          <span className="menu-link px-2">Made with ❤️ for Recipe Management</span>
        </li>
      </ul>
    </div>
  );
};

export default Footer; 