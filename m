Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD1EC02188
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6fSLqef6+onSR0kCdXDFkrQGjjiYR2mDbAyZRQGYc4s=;
  b=I8HwTl1VDKW0/t+uE9q+yav9FU0iEKNQeP9F/Th5VdbaysopOSQQhnmW
   dDIfLH22KBLSj+IaFmfpbbyiHUiUWB5ZySk0gCEW1a9wO9AHs+k9Bc+LW
   pCRmihAzwlm34RVwM93XW7cYzm6SJtT60d4I2sh+Ni33y9m0Xg3eA+vZO
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238392"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3C10E0D83; Mon, 27 Jan 2025 17:17:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E23E1E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:55:27 +0100 (CET)
IronPort-SDR: 67924a4e_I6E3M7a0gBQ4DAz0WMbxZnlzWBJY49iY3zcOJd2nCtrXgkL
 zIdS5NfpOpCFBoLa1Wt9jP6iSxg7n9paaf/HaAQ==
X-IPAS-Result: =?us-ascii?q?A0EBAADWSJJnhcNp+5RQChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBgX8EAQEBAQELAYIbKH1aMwQLSIglhE6HMYIhA4ETk?=
 =?us-ascii?q?DeBVIp6FIFqDwEDAQ05CAECBAEBAwEDhQACinQCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgls7cYElAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARcCCAVeAQEdAQEBAQIBMgENAQEyBQEECx0DGQEXSA4RC?=
 =?us-ascii?q?BWCbAGCQSMCAQUMBrVPGjeCLIEBggwBAQaBCA5CQdoGgWQJgUgBhWqDWoMmX?=
 =?us-ascii?q?3CDfXonD4FVRIEVgTuBN3aCSoE6CgEHCwFpAoVYIoIcF4F1gVVeexGGZoVng?=
 =?us-ascii?q?S+DEoRngTAgiERIgSEDWSwBVRMNCgsHBYFxAzgMCzAVgUlEN4JHaUk6Ag0CN?=
 =?us-ascii?q?YIefIIrhF6ERYRRhVuCFIIUhV9AAwsYDUgRLDcUGwY+bgecFgE8gwQ+ARQfA?=
 =?us-ascii?q?QEwDBwBBwYNCwUKAQcMFgIEAQQXAi4hFAcULRsaAgEOHwkCCwEVklkUCREUg?=
 =?us-ascii?q?w2MXoIdgTeeEYEKNAeEHoFdBgyJB4EijgeHJ02EBIFXiy+GRotAhl1mhTySX?=
 =?us-ascii?q?GSCWIhaglKVJw0cIxmEbDGBZzpJI3AzGiMvgwgJCT0DGQ+OIRmBFQEJgkKFF?=
 =?us-ascii?q?C6BD7ojOzUCOgIHCwEBAwmFRQEBATuJYTJrYAEB?=
IronPort-PHdr: A9a23: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
 Mz0x5qv8wlkaNo8L6vKLexCyV0C38qz
IronPort-Data: A9a23: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
 luvL1awD6uqNrD/dEfnVx/FQUO5NB5TIvWHEQ==
IronPort-HdrOrdr: A9a23:XJdK2KDh4BjYwMjlHemh55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nKpp8mPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WByB9eftWDd0QPDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+HNMQ==
X-Talos-CUID: 9a23:r9B+8GCGMBfpIT/6Eyp+xEk7XZoLTkCHlFP1G0viDkBbbbLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ArWkNkA1VUEz6mV31XqKeDxbyqTUj/b6KWF83rZQ?=
 =?us-ascii?q?9pJOECSErJRSM1D2WXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="107172250"
X-MGA-submission: =?us-ascii?q?MDHqg0N2tWyCzVTkGT2v0jMEikRNi/MEMCXOX5?=
 =?us-ascii?q?uIau3ssLp0GwrxLgR0DSJDMwdFS+MLNrdxWeXdcDc6ukxsjxq+nkCwUO?=
 =?us-ascii?q?Q084zkfmzekkJEoF/CKyPXx5KBA7BX1Au1W65gl2hCB8K3bWC+Hjgg+U?=
 =?us-ascii?q?Yd6KhANfdcchUlKQtm4eloAw=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640524;
	bh=ch2pzJGTc3aYg+byV9YZ1M2zRb5bhcxs85xaDaa3pgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGfsu1iPsFnFtdsQh8Nj+y4TE6cDO8fezGU99FMQ0bAEMF7kWrcLsL3aoUKmiADB4
	 llvLPqijmNjuWZ0saz602r5syqW4RONOpdRKDae2HTqqumHaYBjvceH4qHsv00cLjo
	 U9HU4+xgWPHDH6NKQkhCromw1g7oLofzOuaMHfYb6EHovhylpmp2hr2SHoiFNKNU0b
	 iWNPathzX5FFOMM/qi5D8q0ExCAZDTqQALh672JBDiOh3p799UBS8R1p+UsV1U/rS/
	 In5e9MEKM1AM02C8kn/OMnU2F3zFTsoyDuBe8jBpuozwfTaPjsQmCq/r1o/GCsmO53
	 2ttkVy+FEiJGQ==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A2EA017E0FCA;
	Thu, 23 Jan 2025 14:55:07 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com,
	pawiecz@collabora.com,
	spbnick@gmail.com,
	tales.aparecida@gmail.com,
	workflows@vger.kernel.org,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	daniels@collabora.com,
	helen.koike@collabora.com,
	shreeya.patel@collabora.com,
	denys.f@collabora.com,
	nicolas.dufresne@collabora.com,
	louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com,
	broonie@kernel.org,
	leobras.c@gmail.com,
	groeck@google.com,
	rdunlap@infradead.org,
	geert@linux-m68k.org,
	michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi,
	jarkko@kernel.org
Date: Thu, 23 Jan 2025 19:23:34 +0530
Message-ID: <20250123135342.1468787-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 4/5] kci-gitlab: Add documentation
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2230
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250123135342.1468787-5-vignesh.raman%40collabora.com>

From: Helen Koike <helen.koike@collabora.com>

Add documentation of kci-gitlab.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 Documentation/ci/gitlab-ci/gitlab-ci.rst | 471 +++++++++++++++++++++++
 Documentation/index.rst                  |   7 +
 2 files changed, 478 insertions(+)
 create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst

diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
new file mode 100644
index 000000000000..940a80006923
--- /dev/null
+++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
@@ -0,0 +1,471 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=========================================
+Automated Testing with kci-gitlab
+=========================================
+
+
+This documentation outlines kci-gitlab, a GitLab CI/CD workflow for the
+Linux Kernel. kci-gitlab pipeline is specifically designed for kernel testing.
+It provides kernel developers with an integrated, efficient, and flexible
+testing framework using GitLab's CI/CD capabilities. The workflow is designed
+to simplify testing for developers, allowing tests to be run on any branch at
+any time, without the need for specific infrastructure. Tests are automatically
+triggered on each `git push`, with results displayed in the GitLab UI.
+
+.. image:: images/the-pipeline.png
+   :alt: GitLab-CI pipeline for kernel testing
+   :align: center
+
+Customizations and extensions of the pipeline are possible through the
+scenarios. Scenarios can override existing jobs, change configurations, or
+define new jobs and stages. See :ref:`extending-the-ci` section.
+
+.. note:: If you are unfamiliar with GitLab CI/CD basic concepts, please check
+   the `official documentation <https://docs.gitlab.com/ee/ci/>`_.
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
+Setup
+-----
+
+The kci-gitlab pipeline is set up with minimal configuration required. Pushing code to a
+GitLab repository automatically triggers the pipeline provided the CI/CD configuration
+file path is set as per the instructions given below..
+
+    .. code-block:: bash
+
+      # Download the Linux kernel source code
+      git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+      # Create a repository on GitLab and add it as a remote
+      git remote add gitlab https://gitlab.yourinstance.com/your-username/your-repo.git
+      # In GitlabCI, go to Settings > CI/CD > General pipelines > CI/CD Configuration file
+      # and add the following path to it :-
+      tools/ci/gitlab-ci/gitlab-ci.yml
+      # Push the code to GitLab
+      git push gitlab
+
+.. image:: images/pipelines-on-push.png
+   :alt: Pipeline triggered on push
+   :align: center
+
+Troubleshooting
+---------------
+
+If the pipeline doesn't trigger automatically, check the following:
+
+1. **Enable CI/CD in Project Settings:**
+
+   - Go to `Settings > General > Visibility, project features, permissions`.
+   - Under `Repository`, ensure the `CI/CD` toggle is enabled.
+
+2. **Enable Container Registry:**
+
+   - Still in `Settings`, find the `Container Registry` section.
+   - Enable the `Container Registry` toggle.
+
+3. **CI Minutes and Resources:**
+
+   - If you've exhausted CI minutes or other resources on the Free Tier,
+     consider setting up a local GitLab runner (see below).
+
+Setting Up a Local GitLab Runner
+--------------------------------
+
+You can use your own machine as a runner, instead of the shared runners provided
+by your GitLab instance.
+
+1. **Generate a GitLab Runner Token:**
+
+   - Navigate to `Settings > CI/CD > Runners`.
+   - Expand the `Runners` section and click on "New project runner".
+   - Choose "Run untagged jobs" and click "Create runner".
+   - Copy the provided token.
+
+.. image:: images/new-project-runner.png
+   :alt: New project runner button
+   :align: center
+
+2. **Launch the Runner:**
+
+   - Ensure Docker is installed and your user is added to the Docker group:
+
+    .. code-block:: bash
+
+        sudo usermod -aG docker <your-user>
+
+   - Log in again to apply the changes.
+   - Set up the runner:
+
+    .. code-block:: bash
+
+     export GITLAB_RUNNER_TOKEN=<your_token>
+     export GITLAB_URL=https://gitlab.yourinstance.com  # Use this for instances other than gitlab.com
+     cd tools/ci/gitlab-ci
+     ./bootstrap-gitlab-runner.sh
+
+
+Current Pipeline Jobs
+---------------------
+
+stage: container
+^^^^^^^^^^^^^^^^
+
+**job: debian/x86_64_build debian/arm64_build**
+
+This job prepares the container for x86_64 and arm64 architectures that will be
+used by subsequent jobs. It starts from a base Debian image, installing necessary
+tools for building the kernel and running tests. The resulting image is pushed to
+the project registry and cached. If the image already exists in the registry, it
+won't be rebuilt.
+
+To force a rebuild, update the `FDO_DISTRIBUTION_TAG` variable in the
+`container.yml` file.
+
+stage: static-checks
+^^^^^^^^^^^^^^^^^^^^
+
+**job: checkpatch**
+
+Runs the `checkpatch.pl` script on the last `$ICI_PATCH_SERIES_SIZE` commits.
+This variable is determined by:
+
+- `ICI_PATCH_SERIES_SIZE=` The number of differing patches between target and
+  source branches for merge requests; Or
+- `ICI_PATCH_SERIES_SIZE=$KCI_PATCH_SERIES_SIZE` if `KCI_PATCH_SERIES_SIZE` is
+  set (see :ref:`how-to-set-variables` below).
+
+Defaults to 1 and raises a GitLab warning if unable to identify the number of
+commits.
+
+**job: smatch**
+
+Checks `.c` files in the last `$ICI_PATCH_SERIES_SIZE` commits. Creates a
+job based on architecture and configuration mentioned in the scenario specific
+yaml files.
+If a smatch database exists (see `job: smatch-db-generate` below), it reuses it.
+
+stage: build
+^^^^^^^^^^^^
+
+**job: build:arm32 build:arm64 build:x86_64**
+
+Compiles the kernel for each architecture and configuration
+in `container.yml`.
+
+Raises a GitLab warning if "warning" is found in the build log.
+
+.. image:: images/job-matrix.png
+   :alt: build kernel jobs
+   :align: center
+
+**job: build-docs**
+
+Builds documentation. Creates a job for each documentation type. Not run
+automatically; requires manual triggering.
+
+stage: test
+^^^^^^^^^^^
+
+**job: test-boot**
+
+Runs boot tests using virtme to launch a virtual machine and execute
+`test-boot.sh` script.
+
+stage: cache
+^^^^^^^^^^^^
+
+**job: smatch-db-generate**
+
+Generates a smatch database for use by the `smatch` job. Not run automatically;
+requires manual triggering.
+
+.. _extending-the-ci:
+
+Extending the CI - Test Scenarios (KCI_SCENARIO)
+------------------------------------------------
+
+The kci-gitlab pipeline offers flexibility and adaptability through the use of
+scenarios, enhancing the CI/CD process with broad customization options.
+Key capabilities include:
+
+- **Overriding Existing Jobs:** Tailor existing jobs to meet specific needs or
+  conditions.
+
+- **Changing Configurations:** Dynamically adapt job settings to suit various
+  environments or subsystem requirements.
+
+- **Defining New Jobs and Stages:** Introduce new jobs and stages for additional
+  tests, build processes, or deployment strategies.
+
+These features are particularly useful when a subsystem has distinct
+requirements. For instance, to enable testing different configurations for a
+specific architecture, running static checks with varied arguments, or
+installing specialized tools to conduct targeted tests.
+
+Writing a test scenario
+^^^^^^^^^^^^^^^^^^^^^^^
+
+The kci-gitlab pipeline configuration allows the inclusion of additional `.yml` files
+based on the `KCI_SCENARIO` variable. For example, setting `KCI_SCENARIO` to `my-scenario`
+includes `my-scenario.yml` from the `scenarios/<my-scenario>/` folder.
+
+A different container image can be built for the newly added scenario by modifying
+the FDO_DISTRIBUTION_TAG. FDO_DISTRIBUTION_EXEC can be used to run scripts to install
+the required tools for the container. To illustrate, building a container for a specific
+architecture with a custom configuration can be achieved by overriding the `build` job
+in the `scenarios/<my-scenario>/my-scenario.yml` file:
+
+.. code-block:: yaml
+
+    variables:
+      FDO_DISTRIBUTION_TAG: "<tag>"
+      FDO_DISTRIBUTION_EXEC: <script>
+
+    build:arm64:
+      variables:
+        KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+        KCI_DEFCONFIG: "my/custom/config1"
+
+We also need to add `scenarios/<my-scenario>/test.yml` to override the test-boot job
+and add job to run tests for the scenario.
+
+This modifies the builds and static checks for `arm64` with different configurations.
+
+To select this scenario, trigger the pipeline with KCI_SCENARIO=my-scenario. See
+:ref:`how-to-set-variables` below.
+
+Additionally, we need to add `scenarios/<my-scenario>/test.yml` to override the default
+test-boot job and add job to run tests for the scenario.
+
+DRM scenario
+^^^^^^^^^^^^
+
+Setting `KCI_SCENARIO` to `drm` includes `drm.yml` from the `scenarios/drm/` folder.
+
+A different container image can be built for the newly added `drm` scenario by modifying
+the FDO_DISTRIBUTION_TAG. FDO_DISTRIBUTION_EXEC runs the `prepare-container.sh` script,
+which installs the required tools (e.g., deqp-runner, IGT, Rust) for the container.
+To illustrate, building a container for a specific architecture with a custom
+configuration can be achieved by overriding the build job in the `scenarios/drm/drm.yml` file:
+
+.. code-block:: yaml
+
+    variables:
+      FDO_DISTRIBUTION_TAG: "<tag>"
+      FDO_DISTRIBUTION_EXEC: <prepare-container.sh>
+
+    build:arm64:
+      variables:
+        KCI_KCONFIGS_ENABLE: "DRM_VKMS DRM_BOCHS"
+
+This modifies the builds for x86_64 to enable VKMS driver in the kernel.
+
+Additionally, we need to add `scenarios/drm/test.yml` to override the default
+test-boot job and add job to run tests for the `drm` scenario.
+
+Below is a pipeline running IGT tests using igt-runner provided by
+deqp-runner for :ref:`VKMS <vkms>`.
+
+.. image:: images/drm-vkms.png
+   :alt: DRM vkms job
+   :align: center
+
+`deqp-runner tool <https://gitlab.freedesktop.org/mesa/deqp-runner>`_ supports parallel
+testing of various test suites, including dEQP, Piglit, GTest, and IGT GPU Tools,
+using baseline expectations and known flakes. deqp-runner contains experimental support
+for running IGT tests. `IGT GPU Tools <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_
+is a collection of tools for development and testing of the DRM drivers.
+
+Refer to Documentation/gpu/automated_testing.rst for details regarding
+fails/flakes/skips files.
+
+Variables
+---------
+
+kci-gitlab supports various variables to modify pipeline behavior or for use
+in jobs.
+
+- **CI_ Prefix:** Standard GitLab CI/CD variables (see GitLab documentation).
+- **KCI_ Prefix:** Custom variables defined for kernel CI.
+- **ICI_ Prefix:** Internal variables used between scripts (not for external
+  use).
+
+.. _how-to-set-variables:
+
+How to Set Variables
+--------------------
+
+Variables can be set in several ways:
+
+- **Project Settings:** Under `CI/CD > Variables`.
+- **Pipeline UI:** When triggering a pipeline manually.
+- **Command Line:** When triggering a pipeline manually (see
+  :ref:`triggering-pipelines-from-command-line` below).
+- **YML Files:** Using the `variables` keyword.
+- **Commit Message:** For runtime variables only (see
+  :ref:`setting-variables-in-the-commit-message` below).
+
+.. image:: images/variables.png
+   :alt: Manual creation of pipeline
+   :align: center
+
+Variables Precedence
+--------------------
+
+- **Commit Message Variables:** Highest precedence if evaluated at runtime.
+- **Pipeline Variables:** Next in precedence.
+- **Project Variables:** Follow pipeline variables.
+- **YML File Variables:** Considered after the above levels.
+
+.. _setting-variables-in-the-commit-message:
+
+Setting Variables in the Commit Message
+---------------------------------------
+
+Runtime variables can be set in the commit message. Patterns like
+`KCI_VARIABLE=value` are extracted and exported to the job. To avoid including
+variables in the git history, add them after three dashes (`---`) in the commit
+message, as `git am` ignores text after this line.
+
+Example:
+
+.. code-block::
+
+    Title of my awesome commit
+
+    This is the commit message description of my awesome patch
+    ---
+    KCI_PATCH_SERIES_SIZE=4
+
+Description of Each Variable
+----------------------------
+
+**KCI_BUILD_ARCH**
+    Defines the build architecture to be used in FDO_REPO_SUFFIX for the container
+    image name.
+
+**KCI_KERNEL_ARCH**
+    Defines the architecture to be used in the kernel build jobs and static checks jobs.
+    Usually set in the `container.yml` or overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_DEFCONFIG**
+    Defines the config file to be used in the build-kernel and static checks
+    jobs. Usually set in the `container.yml` or overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_KCONFIGS_{ENABLE,DISABLE,MODULE}**
+    Defines the extra configs to be enabled, disabled or set as a module, used
+    in the build-kernel and static checks jobs. Usually set in the `container.yml` or
+    overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_SCENARIO**
+    Used to select which extra scenario file to include in the pipeline. See
+    :ref:`extending-the-ci` section above. Usually set by the user at project or
+    pipeline level.
+
+**KCI_CHECKPATCH_OPTIONS**
+    Used in `checkpatch.pl "$KCI_CHECKPATCH_OPTIONS"` (see checkpatch
+    documentation). It is commonly used with the --ignore flag to suppress
+    specific warnings generated by checkpatch.pl. It can also be defined in the
+    commit message, since it is evaluated in run time.
+
+**KCI_PATCH_SERIES_SIZE**
+    Used to define the size of the patch series, see `job: checkpatch` section
+    above. It is evaluated in run time, and can be set in the commit message.
+
+.. _triggering-pipelines-from-command-line:
+
+Triggering Pipelines from Command Line
+--------------------------------------
+
+Pipelines can be triggered from the command line with custom variables using the
+`GitLab CLI tool <https://docs.gitlab.com/ee/editor_extensions/gitlab_cli>`_.
+
+Example:
+
+.. code-block:: bash
+
+    glab auth login
+    glab ci run -b gitlab-draft -R https://gitlab.collabora.com/koike/linux/ --variables-env KCI_PATCH_SERIES_SIZE:4
+
+
+Debugging and Replicating Jobs Locally
+--------------------------------------
+
+When a job fails in GitLab CI/CD, it's handy to replicate the issue in the
+same environment used by the GitLab CI/CD runner. This allows for interactive
+execution of each step and the use of debugging tools to pinpoint the failure's
+root cause.
+
+Rather than repeatedly modifying scripts and running the entire pipeline for
+debugging, you can download the specific Docker image used by the job and run it
+locally.
+
+To do this, first inspect the failed job in GitLab CI/CD. Look for a message
+indicating the Docker image used, typically in this format:
+
+   Pulling docker image registry.gitlab.collabora.com/koike/linux/debian/bookworm-slim:2024-02-6-ci-test-1
+
+You can then use this image to run the job locally. For example:
+
+.. code-block:: bash
+
+   IMAGE=registry.gitlab.collabora.com/koike/linux/debian/bookworm-slim:2024-02-6-ci-test-1
+   docker pull $IMAGE
+   docker run --rm -v `pwd`:/linux -w /linux $IMAGE bash
+
+
+Suggestions
+-----------
+
+Send Pipeline Links with Your Patch
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When submitting patches or merge requests, it's highly beneficial to include
+links to the related GitLab CI pipelines. This practice enhances the review
+process in several ways:
+
+1. **Immediate Visibility:** Reviewers can immediately see the results of
+   automated tests, making it easier to assess the patch's impact.
+
+2. **Increased Confidence:** Successful pipeline runs increase confidence in the
+   changes, demonstrating that they pass existing tests.
+
+3. **Efficient Troubleshooting:** If there are issues, pipeline links allow both
+   authors and reviewers to quickly access logs and test results, facilitating
+   faster troubleshooting and iteration.
+
+4. **Transparency:** Providing pipeline links promotes transparency in the
+   development process, making it clear how changes have been verified.
+
+To include a pipeline link in your patch or merge request, simply copy the URL
+of the pipeline from your GitLab project's CI/CD pipeline page and paste it into
+your commit description after three dashes (`---`) or as a reply to your email
+patch.
+
+Always Green Pipeline
+^^^^^^^^^^^^^^^^^^^^^
+
+Maintaining an "always green" pipeline refers to the practice of ensuring that
+the main branch's pipeline is always in a passing state. This approach has
+several advantages:
+
+1. **Reliable Main Branch:** A green pipeline indicates a stable and reliable
+   main branch, which is crucial for continuous integration practices.
+
+2. **Immediate Feedback:** Developers receive immediate feedback on their
+   changes. If a merge causes the pipeline to fail, it's a clear signal that the
+   change introduced an issue.
+
+3. **Faster Iteration:** An always green pipeline facilitates faster development
+   and iteration, as developers can confidently build on top of the latest main
+   branch without worrying about hidden failures.
+
+4. **Culture of Responsibility:** It fosters a culture of responsibility, where
+   developers are encouraged to fix broken builds promptly and avoid merging
+   changes that could disrupt the pipeline.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index f9f525f4c0dd..701e70b54780 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,13 @@ Architecture-specific documentation
 
    CPU architectures <arch/index>
 
+CI: Automated testing documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   ci/gitlab-ci/gitlab-ci
 
 Other documentation
 ===================
-- 
2.43.0

