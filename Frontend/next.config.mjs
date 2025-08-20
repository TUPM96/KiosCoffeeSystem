/** @type {import('next').NextConfig} */

const nextConfig = {
  // output: "standalone",
  reactStrictMode: true,
  productionBrowserSourceMaps: false,
  transpilePackages: [
    'rc-util',
    'rc-table',
    'rc-picker',
    'rc-pagination',
    'rc-input',
    '@ant-design/icons-svg'
  ]
};

export default nextConfig;