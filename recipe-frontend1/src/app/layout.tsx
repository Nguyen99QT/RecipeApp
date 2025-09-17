import type { Metadata } from "next";
import Script from "next/script";
import "./globals.css";

export const metadata: Metadata = {
  title: "Recipe Admin",
  description: "Recipe Admin Dashboard",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" data-bs-theme="light" suppressHydrationWarning>
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" href="/assets/media/illustrations/sigma-1/logo.png" />
        
        {/* Fonts */}
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
        
        {/* Vendor Stylesheets */}
        <link href="/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
        
        {/* Global Stylesheets Bundle */}
        <link href="/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <link href="/assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
        

      </head>
      
      <body 
        id="kt_app_body" 
        data-kt-app-header-fixed="true" 
        data-kt-app-header-fixed-mobile="true" 
        data-kt-app-sidebar-enabled="true" 
        data-kt-app-sidebar-fixed="true" 
        data-kt-app-sidebar-hoverable="true" 
        data-kt-app-sidebar-push-toolbar="true" 
        data-kt-app-sidebar-push-footer="true" 
        data-kt-app-toolbar-enabled="true" 
        data-kt-app-aside-enabled="true" 
        data-kt-app-aside-fixed="true" 
        data-kt-app-aside-push-toolbar="true" 
        data-kt-app-aside-push-footer="true" 
        className="app-default"
        suppressHydrationWarning
      >
        {children}
        
        {/* Load jQuery first */}
        <Script 
          src="https://code.jquery.com/jquery-3.6.4.min.js" 
          strategy="beforeInteractive"
        />
        
        {/* Global Scripts - Load in correct order */}
        <Script 
          src="/assets/plugins/global/plugins.bundle.js" 
          strategy="afterInteractive"
        />
        <Script 
          src="/assets/js/scripts.bundle.js" 
          strategy="afterInteractive"
        />
        <Script 
          src="/assets/plugins/custom/datatables/datatables.bundle.js" 
          strategy="lazyOnload"
        />
        <Script 
          src="/assets/js/custom-file/listing.js" 
          strategy="lazyOnload"
        />
        
        {/* Theme setup and safe initialization script */}
        <Script id="theme-setup" strategy="afterInteractive">
          {`
            (function() {
              try {
                var defaultThemeMode = "light";
                var themeMode = defaultThemeMode;
                
                if (typeof localStorage !== 'undefined' && localStorage.getItem("data-bs-theme")) {
                  themeMode = localStorage.getItem("data-bs-theme");
                  
                  if (themeMode === "system") {
                    themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
                  }
                  
                  // Only update if different from current
                  if (document.documentElement.getAttribute("data-bs-theme") !== themeMode) {
                    document.documentElement.setAttribute("data-bs-theme", themeMode);
                  }
                }
                
                // Override any potential errors from KT components
                window.addEventListener('error', function(e) {
                  if (e.message && e.message.includes('onDOMContentLoaded')) {
                    console.warn('Caught onDOMContentLoaded error:', e.message);
                    e.preventDefault();
                    return true;
                  }
                });
                
                // Safer component initialization
                function safeInitKT() {
                  try {
                    if (typeof KTComponents !== 'undefined' && KTComponents.init) {
                      KTComponents.init();
                    } else if (typeof KTApp !== 'undefined' && KTApp.init) {
                      KTApp.init();
                      if (typeof KTMenu !== 'undefined' && KTMenu.init) KTMenu.init();
                      if (typeof KTDrawer !== 'undefined' && KTDrawer.init) KTDrawer.init();
                      if (typeof KTToggle !== 'undefined' && KTToggle.init) KTToggle.init();
                      if (typeof KTScroll !== 'undefined' && KTScroll.init) KTScroll.init();
                    }
                  } catch(err) {
                    console.warn('KT initialization error:', err);
                  }
                }
                
                // Wait for DOM and scripts
                if (document.readyState === 'loading') {
                  document.addEventListener('DOMContentLoaded', function() {
                    setTimeout(safeInitKT, 100);
                  });
                } else {
                  setTimeout(safeInitKT, 500);
                }
                
              } catch(e) {
                // Silent fail for hydration compatibility
              }
            })();
          `}
        </Script>
      </body>
    </html>
  );
}
