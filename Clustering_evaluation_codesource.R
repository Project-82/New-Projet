#### Package required ####
install.packages("cluster")
install.packages("factoextra")
install.packages("kohonen")
install.packages("class")
install.packages("MASS")
install.packages("mclust")
install.packages("clValid")

#### Libraries loaded ####
library("cluster")
library("factoextra")
library("kohonen")
library("class")
library("MASS")
library("mclust")
library("clValid")

### Datasets used 
dataset1 = read.table(file= "AT_salt stress comparison-1000.txt", header=T, dec=".")     #AT_salt stress is name of dataset1
dataset2 = read.table(file= "Tomato_salt stress comparison-1000.txt", header=T, dec=".") #Tomato_salt stress is name of dataset2
dataset3 = read.table(file="MT_salt stress comparison-1000.txt", header=T, dec=".")      #MT_salt stress is name of dataset3

### Dataset Prepared 
plant_dataset <- na.omit(dataset1)      # delet the missing values of dataset1
plant_dataset <- scale  (dataset1)      # standardize variables of dataset1

### Clustering algorithms used

## Example of clustering with K=5 ##

## HIERARCHICAL CLUSTERING ALGORITHMS

# AGNES clustering
set.seed(123)
pam.res<-eclust(plant_dataset, "agnes", k = 5) 
head(agnes.res$cluster, 15) 
fviz_cluster(agnes.res) # show clusters

# DIANA clustering
set.seed(123)
diana.res<-eclust(plant_dataset, "diana", k = 5) 
head(diana.res$cluster, 15) 
fviz_cluster(diana.res) # show clusters

## PARTITIONING CLUSTERING ALGORITHMS

# K-Means clustering
set.seed(123)
kmeans.res <- eclust(plant_dataset, "kmeans", k = 5)
head(kmeans.res$cluster, 15)               # shows the 15 instances and in which cluster they were assigned
fviz_cluster(kmeans.res)          # visualize clusters

# PAM clustering
set.seed(123)
pam.res<-eclust(plant_dataset, "pam", k = 5) 
head(pam.res$cluster, 15) 
fviz_cluster(pam.res) # show clusters

# clara clustering
set.seed(123)
clara.res<-eclust(plant_dataset, "pam", k = 5) 
head(clara.res$cluster, 15) 
fviz_cluster(clara.res) # show clusters

## FUZZY CLUSTERING ALGORITHMS

# FANNY clustering
set.seed(123)
fanny.res<-eclust(plant_dataset, "fanny", k = 5) 
head(fanny.res$cluster, 15) 
fviz_cluster(fanny.res) # show clusters

## MODEL CLUSTERING ALGORITHMS
set.seed(123)
som.res<- som(plant_dataset, xdim=5, ydim=6)  # specify the x-dimension and the y-dimension of the map

#### Choose the best clustering algorithm with clValid ####

# Internal validation

clmethods    <- c("hierarchical","diana","kmeans","pam","clara","som","fanny")
internal.val <- clValid(plant_dataset, nClust = 2:10,clMethods = clmethods, maxitems=1000,validation = "internal")
summary(internal.val)

# Relative validation

clmethods     <- c("hierarchical","diana","kmeans","pam","clara","som","fanny")
stability.val <- clValid(plant_dataset, nClust = 2:10,clMethods = clmethods, maxitems=1000,validation = "stability")
summary(stability.val) 
