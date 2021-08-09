# Feature Selection for Multi-label Classification using Multivariate Mutual Information

## Abstract

Recently, classification tasks that naturally emerge in multi-label domains, such as text categorization, automatic scene annotation, and gene function prediction, have attracted great interest. As in traditional single-label classification, feature selection plays an important role in multi-label classification. However, recent feature selection methods require preprocessing steps that transform the label set into a single label, resulting in subsequent additional problems. In this paper, we propose a feature selection method for multi-label classification that naturally derives from mutual information between selected features and the label set. The proposed method was applied to several multi-label classification problems and compared with conventional methods. The experimental results demonstrate that the proposed method improves the classification performance to a great extent and has proved to be a useful method in selecting features for multi-label classification problems.

This program is designed to perform the feature selection for multi-label data set. This method deals with standard multi-label data set, in which the number of given label is larger than one.

This software is a Matlab implementation of proposed method, highy specialized on problems of categorical data set classification. The original version of this program was written by Jaesung Lee.

### [Paper]

<!-- The main technical ideas behind how this program works appear in these papers: -->

Jaesung Lee, and Dae-Won Kim, [“Feature Selection for Multi-label Classification using Multivariate Mutual Information,”](http://air.cau.ac.kr/softwares/pmu/lee2013feature.pdf) Pattern Recognition Letters, 34, 2013.

<!-- McGill, [“Multivariate Information Transmission,”]() IRE Professional Group on Information Theory, 4, 1954.
 -->
## License

This program is available for download for non-commercial use, licensed under the GNU General Public License, which is allows its use for research purposes or other free software projects but does not allow its incorporation into any type of commerical software.

## Sample Input and Output

It will return the index of input categorical features in orders of conditional dependency, named for user-specified variable. This code can executed under Matlab command window.

### [Usage]:
   `>> idx = pmu( features, labels, nums );`

### [Description]
   features – a matrix that is composed of features \
   labels – a matrix represents labels of each pattern is assigned to \
   nums – the number of features to be selected

By convention in the input features matrix, rows represent data (e.g. patterns) and columns represent features.

The information for other programs are:

   `>> f = dis_efi( single_feature, bins )` : Discretize a numerical feature into a categorized feature \
   `>> ent = p_entropy( features )` : Calculate the entropy of given (multivariate) feature 

   `>> idx = ela_chi( features, labels )` : Perform the chi-squre based feature selection on transformed label using the Entropy based Label Assignment \
   `>> idx = ppt_chi( features, labels )` : Perform the chi-squre based feature selection on transformed label using the Pruned Problem Transformation \
   `>> idx = ppt_mi( features, labels )` : Perform the mutual information based feature selection on transformed label using the Pruned Problem Transformation 
