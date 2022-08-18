resource "aws_eks_cluster" "as-app-cluster" {
    name = "as-app-cluster"
    role_arn = aws_iam_role.i_am_role.arn

    vpc_config {
      subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id]
    }

    depends_on = [
        aws_iam_role.i_am_role,
        aws_iam_role_policy_attachment.amazon-eks-cluster-policy,
        aws_iam_role_policy_attachment.amazon-ec2-container-registry-eks,
    ]
}

resource "aws_eks_node_group" "as-app-node" {
  cluster_name = aws_eks_cluster.as-app-cluster.name
  node_group_name = "as-app-node-group"
  node_role_arn = aws_iam_role.as-app-node-role.arn
  subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id]
#   ami_type = "ami-0c956e207f9d113d5"
  # instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 1
  }
  update_config {
    max_unavailable = 1
  }

    depends_on = [
      aws_iam_role_policy_attachment.amazon-eks-worker-node-policy,
      aws_iam_role_policy_attachment.amazon-ec2-container-registry-read-only,
      aws_iam_role_policy_attachment.amazon-eks-cni-policy
    ]
}