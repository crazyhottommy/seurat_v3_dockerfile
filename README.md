# seurat_v3_dockerfile
docker file for seurat v3

```bash
git clone https://github.com/crazyhottommy/seurat_v3_dockerfile

cd seurat_v3_dockerfile
docker build . -t seuratv3

docker run -it seuratv3 bash

docker tag seuratv3 crazyhottommy/seuratv3
docker push crazyhottommy/seuratv3
```