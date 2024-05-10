# Gunakan image Nginx terbaru
FROM nginx:latest

# Hapus default configuration Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Salin file konfigurasi Nginx
COPY nginx/default.conf /etc/nginx/conf.d

# Expose port 80 ke host
EXPOSE 80

# Atur perintah untuk memulai Nginx
CMD ["nginx", "-g", "daemon off;"]

