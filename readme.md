# README

下記記事をやってみたリポジトリです。

[【ハンズオン】Amazon EKSをTerraformで構築してみる | NHN テコラス Tech Blog | AWS、機械学習、IoTなどの技術ブログ](https://techblog.nhn-techorus.com/archives/21248)

## 環境構築

```bash
terraform apply
```

```bash
docker buildx build --platform linux/amd64 ./ -t sample_nginx
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 009578387149.dkr.ecr.ap-northeast-1.amazonaws.com
docker tag sample_nginx:latest 009578387149.dkr.ecr.ap-northeast-1.amazonaws.com/hoge-web-repository:latest
docker push 009578387149.dkr.ecr.ap-northeast-1.amazonaws.com/hoge-web-repository:latest
```

```bash
aws eks update-kubeconfig --region ap-northeast-1 --name hoge-eks
kubectl config current-context
kubectl apply -f aws-load-balancer-controller-service-account.yaml
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=hoge-eks --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
```

```bash
kubectl apply -f nginx.yaml
kubectl apply -f alb.yaml
```

```bash
kubectl describe ingress sample-eks-ingress -n sample-eks
kubectl get deployment -n kube-system aws-load-balancer-controller
kubectl get pods -n sample-eks -o wide
```

## 後始末

```sh
kubectl delete -f alb.yaml
terraform destroy
```
