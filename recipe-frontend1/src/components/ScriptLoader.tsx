'use client';

import { useEffect } from 'react';

declare global {
  interface Window {
    $?: any;
    jQuery?: any;
    KTApp?: any;
    KTMenu?: any;
    KTDrawer?: any;
    KTToggle?: any;
    KTScroll?: any;
    KTUtil?: any;
    KTComponents?: any;
  }
}

const ScriptLoader = () => {
  useEffect(() => {
    // Simple reinit on route changes only
    const handleRouteChange = () => {
      setTimeout(() => {
        try {
          if (typeof window !== 'undefined') {
            // Try multiple approaches for reinit
            if (window.KTComponents && typeof window.KTComponents.init === 'function') {
              window.KTComponents.init();
            } else if (window.KTApp && typeof window.KTApp.init === 'function') {
              window.KTApp.init();
            }
          }
        } catch (error) {
          // Silent fail
        }
      }, 300);
    };
    
    // Only listen for navigation, let layout script handle initial load
    window.addEventListener('popstate', handleRouteChange);
    
    return () => {
      window.removeEventListener('popstate', handleRouteChange);
    };
  }, []);

  return null;
};

export default ScriptLoader; 