#ifndef LIBTORCH_H
#define LIBTORCH_H

#include <torch/torch.h>
#include <torch/script.h>
#include <memory>
#include <string>

using Tensor = torch::Tensor;

bool is_mps_available();
std::unique_ptr<torch::Tensor>  create_tensor_on_mps();
std::unique_ptr<std::string> tensor_to_string(const torch::Tensor& tensor);

#endif // LIBTORCH_H