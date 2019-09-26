# Copyright 2016 The Upbound Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ====================================================================================
# Options

# ====================================================================================
# Setup go environment

-include golang.mk

# the packages to be built statically, for example, $(GO_PROJECT)/cmd/mytool
ifeq ($(CRD_DIR),)
$(error please set CRD_DIR prior to including k8scontrollers.mk)
endif

# ====================================================================================
# k8scontrollers Targets

# Generate manifests e.g. CRD, RBAC etc.
manifests: $(CONTROLLERGEN)
	@$(INFO) Generating CRD manifests
	@$(CONTROLLERGEN) crd:trivialVersions=true paths=./aws/... output:dir=$(CRD_DIR)
	@$(OK) Generating CRD manifests

# ====================================================================================
# Common Targets

# ====================================================================================
# Special Targets

define K8S_CONTROLLERS_HELPTEXT
Kubernetes Controllers Targets:
  manifests       Generates Kubernetes custom resources manifests (e.g. CRDs RBACs, ...)
endef
export K8S_CONTROLLERS_HELPTEXT

help-special: k8s_controllers.help
k8s_controllers.help:
	@echo "$$K8S_CONTROLLERS_HELPTEXT"
# ====================================================================================
# Tools install targets