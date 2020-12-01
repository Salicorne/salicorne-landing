---
title: "Kubectl Aliases"
date: 2020-12-01T11:55:24+01:00
draft: false
layout: "post"
Author: "Salicorne"
img: "kube.png"
categories: ["kubernetes", "tech"]
---

Utilisant kubectl au quotidien, et étant ~~de nature feignante~~ prompt à automatiser, j'ai rapidement mis en place une liste d'alias pour me simplifier la vie. Cette liste est évidemment ammenée à évoluer, mais voilà déjà un début !

## Kubectl

```bash
# Commandes basiques
alias k='kubectl'
alias kg='kubectl get'
alias ka='kubectl apply'
alias kl='kubectl logs --tail 100'
alias ke='kubectl exec -it'
alias ked='kubectl edit'
alias kdesc='kubectl describe'
alias kdel='kubectl delete'

# Commandes de supervision, si xxx est installé sur le cluster
alias ktop='kubectl top'
alias ktopp='kubectl top pods --all-namespaces'

# Commandes de configuration, pratiques pour jongler entre plusieurs clusters !
alias kx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Lance un pod Alpine dans le namespace actuel et s'y attache, supprime le pod ensuite.
alias kdbg='kubectl run -it --rm --restart=Never alpine --image alpine sh'

# Utilise VS-Code comme éditeur, uniquement si on est dans un terminal géré par Code.
# L'édition se fera dans la fenêtre actuelle. 
# L'option --wait est nécessaire pour que Code garde la main sur la commande jusqu'à ce que l'onglet d'édition soit fermé !
if [ $commands[code] ]; then
  export KUBE_EDITOR="code --wait" 
fi

# Charge la complétion de kubectl et Helm
source <(kubectl completion zsh)
source <(helm completion zsh)
```

Ces quelques commandes permettent de pas mal simplifier les opérations du quotidien : plus rapide de taper `kg po -A` plutôt que `kubectl get pods --all-namespaces` pour vérifier l'état du cluster !

---

## Nginx Ingress Controller

Quelques alias sont également pratiques pour les clusters qui utilisent [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/) : 

```bash
# Affiche la chaine de certification (à adapter selon le nom de secret utilisé) :
alias ngx_ca='kubectl get secret -n ingress-nginx ca-secret -o jsonpath={.data.ca\.crt} | base64 -d'

# Si une CRL est utilisée, elle vit dans le même secret et peut être affichée de la même façon :
alias ngx_crl='kubectl get secret -n ingress-nginx ca-secret -o jsonpath={.data.ca\.crl} | base64 -d'

# Redémarrage progressif de l'ingress controller
alias ngx_rollout='kubectl rollout restart deploy nginx-ingress-controller -n ingress-nginx'
``` 
