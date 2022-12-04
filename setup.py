from setuptools import find_packages,setup 

def get_requirements():...

setup(
    name="sensor",
    version="0.0.1",
    author="mukulvyas",
    author_email="vyasmukulg@gmail.com",
    packages = find_packages(),
    install_requires=get_requirements(),
)
