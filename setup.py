import setuptools

setuptools.setup(
  name="jupyter-texmaker-server",
  # py_modules rather than packages, since we only have 1 file
  py_modules=['texmaker'],
  entry_points={
      'jupyter_serverproxy_servers': [
          # name = packagename:function_name
          'texmaker = texmaker:setup_texmaker',
      ]
  },
  packages=setuptools.find_packages(),
      keywords=['Jupyter'],
      classifiers=['Framework :: Jupyter'],
  install_requires=[
    'jupyter-server-proxy'
  ],
)