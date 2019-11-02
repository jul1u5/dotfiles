{
  services = {
    compton = {
      enable = true;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      vSync = true;
      settings = {
        paint-on-overlay = true;
        glx-no-stencil = true;
        glx-no-rebind-pixmap = true;
        glx-swap-method = "buffer-age";
        sw-opti = true;
        xrender-sync-fence = true;
      };
    };
  };
}