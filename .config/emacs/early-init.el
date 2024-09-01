;; Startup optimization
;; Set high at init for quick start up
(setq gc-cons-threshold most-positive-fixnum)
(setq package-enable-at-startup nil)
(setq frame-resize-pixelwise t
      window-resize-pixelwise t)

;; apparently faster than setting the modes
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq inhibit-compacting-font-caches t)
(setq-default pgtk-wait-for-event-timeout 0)
(setq frame-inhibit-implied-resize t)
