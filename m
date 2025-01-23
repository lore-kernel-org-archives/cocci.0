Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249EEC0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qCFO7ETVm5PHeHbrB9SMZ9G4VGZp1ujDS49XAMei7Zs=;
  b=dWliyp3kEvVXZeMlaY8R/KXf3Hjaq/pF1NkSntwzI+kBRZo/8OEk9RDb
   fYMfkK6ybW4PuL/TL46ai3Lh/HfTzr4+pom6yTqBKaG7Jj1tWX1mXCbYW
   T18ryvBaAZSXYzy6l7CXj2JH4HzyHFP7utspBIvJbuzOX0S6cIXWMive3
   o=;
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
   d="scan'208";a="205238268"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EF03E0D2B; Mon, 27 Jan 2025 17:17:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4BD2AE0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:54:32 +0100 (CET)
IronPort-SDR: 67924a17_a152gFvOf5iOHQgFFSgVZ91Os1yoVQYwrjkhX29kLyKQSMP
 yFJbNiJIzUVvEt7uTxhsxvyWutvUIzFDWgfSF0A==
X-IPAS-Result: =?us-ascii?q?A0ECAADRSZJnhcNp+5RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgkN9WjMEC0iIJYROhzGCIQOBE5A3jE4UgWoPA?=
 =?us-ascii?q?QMBDT0EAQIEAQEDAQOFAAKKdAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBQEmFew2CWztxgSUBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFwIIBV4BAR4CAQMaARcBDQEBMgUBDx0DMUgOEQgbgmYBgmQCAQUMBrhTg?=
 =?us-ascii?q?QGCDAEBBlI2DtsJgWQJgUgBhWqHX3CDfXonD4FVRIEVgTuBNwdvgkMHFwGBJ?=
 =?us-ascii?q?CMChlyCM4F1gVVegQyGZoQsgTuBL4MShGeBUIhESIEhA1ksAVUTDQoLBwWBc?=
 =?us-ascii?q?QM4DAswFYFJRDeCR2lJOgINAjWCHnyCK4RehEWEUYVbghSCFII2gylAAwsYD?=
 =?us-ascii?q?UgRLDcUGwY+bgecFgE8gn1zBwEVJxYGCBMHCQoBCSIFBHwMbDoRMpJDFwkSg?=
 =?us-ascii?q?xeMXoIdgTefGzQHhB6BXQYMiQeBIpIkgwpNhASBV4svhkY6kkmYfIJYiyyVN?=
 =?us-ascii?q?BwjDguEbDGBZzqBXDMaI1CCZwlGAxkPjiEZg2EohGwugQ+6JDs1AgkxAgcLA?=
 =?us-ascii?q?QEDCYVFAQEBO4oTa2ABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:8Pzfr6+kNa9BeMEV7tFuk+DVI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB1/73TJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7BZmnbUQKTRekJ0WKh+UyEJ8SUzIBgPM
 lbH5SWcOeAbmRHsQ==
X-Talos-CUID: 9a23:B85+/268DFhuRRAs5tssz34qHJomVXHkzGbwDRWRIl1YaYLWRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3ArEB4Pg68RzqIjDm5DMVIQvYYxoxRvo28OkU9y64?=
 =?us-ascii?q?WhNe7NHd1ATSEkCSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204665615"
X-MGA-submission: =?us-ascii?q?MDFIRT8o+Go9lKq56RvIyZIW/kqZSdEQ7fzNgM?=
 =?us-ascii?q?rd7IrN8xm5LgLJa44GAGnlNo00M5CbN+dJ7popX3IoYZxd9Bj4rYHMOF?=
 =?us-ascii?q?x7Vt9XPAoMQee3JiyCVSQH/JULZkvfKLMRenxASJHlVS3clXNc1ogDrC?=
 =?us-ascii?q?tbiHpoh310UTJi04QlsSLb4Q=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:54:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640471;
	bh=ymIF6inKXRPiFSZhHMTKhGKEn2mKdPGLDRrFj3J1ZlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcVssDJ4vXR8Mm88iHKBUKZBpX3TLy8yho+/Jt4cHJvz3GdE1lyq/CoRwbKD67w1u
	 xzyJywmgLOsn/iVzoX8uQvlkbfPk2D2SV1CSNQ1SnyJHGO+NpWmU4DrxJJZZx/tJ3w
	 ea4EdYTBOE2uYfXWOrDIx24jo3RocwvNFA5dQyve6imbJCAl7vC8ZxfI581OmvtaPo
	 chFqK0nc7U5qyf022h2ScNuvWikLtz3x2kvYrGdHnE7XqEJ6LvrPJLATGy/da+Q3Dk
	 cmYEZAIbYwlCpzndusGVeHkQICJ1o1QKEslraZ8aZVo5V7s7+U4HoEMb/i1h57N5KY
	 XJivogJQPkFBw==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 52D1E17E0EA9;
	Thu, 23 Jan 2025 14:54:14 +0100 (CET)
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
Date: Thu, 23 Jan 2025 19:23:31 +0530
Message-ID: <20250123135342.1468787-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 1/5] kci-gitlab: Introducing GitLab-CI Pipeline
 for Kernel Testing
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2227
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250123135342.1468787-2-vignesh.raman%40collabora.com>

From: Helen Koike <helen.koike@collabora.com>

This patch introduces a .gitlab-ci file in the tools/ci/gitlab-ci/
folder and other yml and script files, defining a basic test pipeline
triggered by code pushes to a GitLab-CI instance. This initial
version includes static checks (checkpatch and smatch for now),
build tests across various architectures and configurations,
and boot test using virtme. It introduces a flexible 'scenarios'
mechanism for subsystem-specific extensions.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Signed-off-by: Tales Aparecida <tales.aparecida@redhat.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 tools/ci/gitlab-ci/arm_cross_compile.yml      |   9 ++
 tools/ci/gitlab-ci/arm_native_compile.yml     |  20 +++
 tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh |  55 +++++++++
 tools/ci/gitlab-ci/build.yml                  |  43 +++++++
 tools/ci/gitlab-ci/cache.yml                  |  24 ++++
 tools/ci/gitlab-ci/ci-scripts/build-docs.sh   |  35 ++++++
 tools/ci/gitlab-ci/ci-scripts/build-kernel.sh |  43 +++++++
 .../ci/gitlab-ci/ci-scripts/ici-functions.sh  | 106 ++++++++++++++++
 .../ci/gitlab-ci/ci-scripts/install-smatch.sh |  13 ++
 .../ci-scripts/parse_commit_message.sh        |  27 +++++
 .../ci/gitlab-ci/ci-scripts/run-checkpatch.sh |  20 +++
 tools/ci/gitlab-ci/ci-scripts/run-smatch.sh   |  45 +++++++
 tools/ci/gitlab-ci/ci-scripts/run-virtme.sh   |  52 ++++++++
 tools/ci/gitlab-ci/ci-scripts/test-boot.sh    |  14 +++
 tools/ci/gitlab-ci/container.yml              | 114 ++++++++++++++++++
 tools/ci/gitlab-ci/docker-compose.yaml        |  18 +++
 tools/ci/gitlab-ci/gitlab-ci.yml              |  72 +++++++++++
 tools/ci/gitlab-ci/scenarios.yml              |  15 +++
 tools/ci/gitlab-ci/scenarios/drm/drm.yml      |  11 ++
 .../scenarios/file-systems/file-systems.yml   |  11 ++
 tools/ci/gitlab-ci/scenarios/media/media.yml  |  11 ++
 .../gitlab-ci/scenarios/network/network.yml   |  11 ++
 tools/ci/gitlab-ci/static-checks.yml          |  21 ++++
 tools/ci/gitlab-ci/test.yml                   |  16 +++
 24 files changed, 806 insertions(+)
 create mode 100644 tools/ci/gitlab-ci/arm_cross_compile.yml
 create mode 100644 tools/ci/gitlab-ci/arm_native_compile.yml
 create mode 100755 tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh
 create mode 100644 tools/ci/gitlab-ci/build.yml
 create mode 100644 tools/ci/gitlab-ci/cache.yml
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/build-docs.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/build-kernel.sh
 create mode 100644 tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/install-smatch.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/run-smatch.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/run-virtme.sh
 create mode 100755 tools/ci/gitlab-ci/ci-scripts/test-boot.sh
 create mode 100644 tools/ci/gitlab-ci/container.yml
 create mode 100644 tools/ci/gitlab-ci/docker-compose.yaml
 create mode 100644 tools/ci/gitlab-ci/gitlab-ci.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/drm.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/file-systems/file-systems.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/media/media.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/network/network.yml
 create mode 100644 tools/ci/gitlab-ci/static-checks.yml
 create mode 100644 tools/ci/gitlab-ci/test.yml

diff --git a/tools/ci/gitlab-ci/arm_cross_compile.yml b/tools/ci/gitlab-ci/arm_cross_compile.yml
new file mode 100644
index 000000000000..a52b981b4312
--- /dev/null
+++ b/tools/ci/gitlab-ci/arm_cross_compile.yml
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+.use-debian/arm64_build:
+  extends:
+    - .use-debian/x86_64_build
+  needs:
+    - job: debian/x86_64_build
diff --git a/tools/ci/gitlab-ci/arm_native_compile.yml b/tools/ci/gitlab-ci/arm_native_compile.yml
new file mode 100644
index 000000000000..649eeebad234
--- /dev/null
+++ b/tools/ci/gitlab-ci/arm_native_compile.yml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+debian/arm64_build:
+  extends:
+    - .debian-arm64
+    - .fdo.container-build@debian
+  tags:
+    - aarch64
+  stage: container
+
+.use-debian/arm64_build:
+  tags:
+    - aarch64
+  extends:
+    - .debian-arm64
+    - .fdo.suffixed-image@debian
+  needs:
+    - job: debian/arm64_build
diff --git a/tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh b/tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh
new file mode 100755
index 000000000000..73238960d088
--- /dev/null
+++ b/tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -eo pipefail
+
+# Define variables
+CONFIG_VOLUME="/srv/gitlab-runner/config" # Path to your GitLab Runner config
+
+# Check if RUNNER_REGISTRATION_TOKEN is set
+if [ -z "${RUNNER_REGISTRATION_TOKEN}" ]; then
+    echo "Error: RUNNER_REGISTRATION_TOKEN is not set."
+    echo "Please set the RUNNER_REGISTRATION_TOKEN environment variable and try again."
+    exit 1
+fi
+
+# Check if GITLAB_URL is set
+if [ -z "${GITLAB_URL}" ]; then
+    GITLAB_URL="https://gitlab.com/"
+    echo "Info: GITLAB_URL is not set. Using the default $GITLAB_URL"
+    echo "Please set the RUNNER_REGISTRATION_TOKEN environment variable and try again."
+fi
+
+# Check if docker-compose is installed
+if ! command -v docker-compose &> /dev/null
+then
+    echo "docker-compose could not be found. Please install it first."
+    exit 1
+fi
+
+# Start the GitLab Runner using Docker Compose
+echo "Starting GitLab Runner..."
+docker-compose up -d
+
+# Wait for a few seconds to ensure the service is up
+sleep 5
+
+# Register the GitLab Runner
+echo "Registering GitLab Runner..."
+docker run --rm -v ${CONFIG_VOLUME}:/etc/gitlab-runner gitlab/gitlab-runner register \
+  --non-interactive \
+  --url ${GITLAB_URL} \
+  --token ${RUNNER_REGISTRATION_TOKEN} \
+  --executor docker \
+  --docker-image "alpine:latest" \
+  --description "Docker Runner" \
+  --docker-privileged
+
+echo ""
+echo "INFO: To configure the number of concurrent jobs, edit the value of"
+echo "INFO: concurrent in ${CONFIG_VOLUME}/config.toml, than restart the GitLab"
+echo "INFO: Runner using docker-compose restart"
+echo ""
+echo "GitLab Runner setup complete."
diff --git a/tools/ci/gitlab-ci/build.yml b/tools/ci/gitlab-ci/build.yml
new file mode 100644
index 000000000000..ce47b8701a6d
--- /dev/null
+++ b/tools/ci/gitlab-ci/build.yml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.build-doc:
+  extends: .use-debian/x86_64_build
+  stage: build
+
+.build-common:
+  stage: build
+  timeout: "1h30m"
+  script:
+    - ./tools/ci/gitlab-ci/ci-scripts/build-kernel.sh
+
+build:x86_64:
+  extends:
+  - .use-debian/x86_64_build
+  - .build-common
+  - .x86_64-config
+
+build:arm64:
+  extends:
+  - .use-debian/arm64_build
+  - .build-common
+  - .arm64-config
+
+build:arm32:
+  extends:
+  - .use-debian/arm64_build
+  - .build-common
+  - .arm32-config
+
+build-docs:
+  extends:
+    - .build-doc
+  parallel:
+    matrix:
+      - ICI_DOC_TYPE: "htmldocs"
+      - ICI_DOC_TYPE: "latexdocs"
+      - ICI_DOC_TYPE: "epubdocs"
+  script:
+    - ./tools/ci/gitlab-ci/ci-scripts/build-docs.sh
+  when: manual
diff --git a/tools/ci/gitlab-ci/cache.yml b/tools/ci/gitlab-ci/cache.yml
new file mode 100644
index 000000000000..88dca0ee74a0
--- /dev/null
+++ b/tools/ci/gitlab-ci/cache.yml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Smatch db is saved to a cached folder, so it can be used by other jobs and pipelines.
+# It is set to manual so it can be run when needed
+
+.use-cache-smatch-db:
+  cache:
+    - key: smatch-db
+      paths:
+        - /smatch/smatch_data
+
+smatch-db-generate:
+  stage: cache
+  extends:
+    - .use-debian/x86_64_build
+    - .use-cache-smatch-db
+  script:
+    - source tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
+    - ici_prepare_build
+    - cp build/.config .
+    - /smatch/smatch_scripts/build_kernel_data.sh
+  when: manual
diff --git a/tools/ci/gitlab-ci/ci-scripts/build-docs.sh b/tools/ci/gitlab-ci/ci-scripts/build-docs.sh
new file mode 100755
index 000000000000..43c6782d8540
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/build-docs.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_get_patch_series_size
+
+# Get the list of modified files in the last $ICI_PATCH_SERIES_SIZE commits
+MODIFIED_DOC_FILES=$(git diff HEAD~$ICI_PATCH_SERIES_SIZE --name-only -- Documentation/)
+
+make -j$(nproc) "$ICI_DOC_TYPE" 2>&1 | tee output.txt
+
+mkdir -p "${CI_PROJECT_DIR}/artifacts"
+mv Documentation/output "${CI_PROJECT_DIR}/artifacts/Documentation-output"
+
+# Check if any of the MODIFIED_DOC_FILES generated a warning
+# NOTE: the alternative solution was to touch the modified files and run make
+# again, but too many warnings still appear
+for file in $MODIFIED_DOC_FILES; do
+    if grep -qi "warning" output.txt && grep -q "$file" output.txt; then
+        echo "Warning found in $file"
+        exit 101
+    fi
+done
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the"
+    echo " whole series. Exiting with a warning."
+    exit 101
+fi
diff --git a/tools/ci/gitlab-ci/ci-scripts/build-kernel.sh b/tools/ci/gitlab-ci/ci-scripts/build-kernel.sh
new file mode 100755
index 000000000000..b9e56fde208c
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/build-kernel.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_prepare_build
+
+pushd build
+
+# compile the kernel
+make CF=-D__CHECK_ENDIAN__ \
+    -C "$ICI_KERNEL_DIR" \
+    O=$(pwd) \
+    -j$(nproc) \
+    $KCI_KERNEL_IMAGE_NAME \
+    2>&1 | tee output.txt
+
+export INSTALL_PATH="${CI_PROJECT_DIR}/artifacts/"
+INSTALL_PATH+="kernel-install-${KCI_KERNEL_ARCH}"
+mkdir -p "$INSTALL_PATH"
+
+for image in ${KCI_KERNEL_IMAGE_NAME}; do
+    cp arch/${KCI_KERNEL_ARCH}/boot/${image} $INSTALL_PATH/.
+done
+
+make modules
+
+# install kernel modules to artifacts/kernel-install
+make -C "$ICI_KERNEL_DIR" O=$(pwd) modules_install INSTALL_MOD_PATH="$INSTALL_PATH"
+
+# export config as artifact
+cp .config "${CI_PROJECT_DIR}/artifacts/${KCI_KERNEL_ARCH}_config"
+
+# if the compilation has warnings, exit with the warning code
+if grep -iq "warning" output.txt; then
+    exit 101
+fi
+
+popd
diff --git a/tools/ci/gitlab-ci/ci-scripts/ici-functions.sh b/tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
new file mode 100644
index 000000000000..6b769be4de83
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
@@ -0,0 +1,106 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+# internal CI bash functions
+
+# convention:
+# KCI_<VARIABLE_NAME> for variables defined by the user (outside of this script)
+# ICI_<VARIABLE_NAME> for variables defined internally for usage between scripts
+# CI_<VARIABLE_NAME> for variables defined by GitLab CI
+
+
+ici_prepare_build() {
+    BUILD_DIR="${1:-build}"
+
+    echo ""
+    echo "Architecture: $KCI_KERNEL_ARCH"
+    echo "Defconfig: $KCI_DEFCONFIG"
+    echo ""
+
+    # Get the current directory if KCI_KERNEL_DIR is not set
+    ICI_KERNEL_DIR="${KCI_KERNEL_DIR:-$(pwd)}"
+
+    cd "$ICI_KERNEL_DIR" || { echo "Kernel directory not found"; exit 1; }
+
+    # Clean up stale rebases that GitLab might not have removed when reusing a checkout dir
+    rm -rf .git/rebase-apply
+
+    if [[ "$KCI_KERNEL_ARCH" = "arm64" ]]; then
+        GCC_ARCH="aarch64-linux-gnu"
+    elif [[ "$KCI_KERNEL_ARCH" = "arm" ]]; then
+        GCC_ARCH="arm-linux-gnueabihf"
+    else
+        GCC_ARCH="x86_64-linux-gnu"
+    fi
+
+    # Set ARCH and CROSS_COMPILE if:
+    # - The kernel architecture is "arm" (default cross-compilation case), or
+    # - The CI server host is not "gitlab.freedesktop.org"
+    if [[ "$KCI_KERNEL_ARCH" = "arm" ]] || [[ "$CI_SERVER_HOST" != "gitlab.freedesktop.org" ]]; then
+        export ARCH=${KCI_KERNEL_ARCH}
+        export CROSS_COMPILE="${GCC_ARCH}-"
+    fi
+
+    mkdir -p "$BUILD_DIR"
+
+    pushd "$BUILD_DIR" || { echo "Failed to create $BUILD_DIR directory"; exit 1; }
+
+    # generate defconfig
+    make -C "$ICI_KERNEL_DIR" O=$(pwd) $(basename ${KCI_DEFCONFIG-"defconfig"})
+
+    # add extra configs from variable KCI_KCONFIGS_{ENABLE,DISABLE,MODULE}
+    for opt in $KCI_KCONFIGS_ENABLE; do
+        ../scripts/config --file .config --enable CONFIG_$opt
+    done
+    for opt in $KCI_KCONFIGS_DISABLE; do
+        ../scripts/config --file .config --disable CONFIG_$opt
+    done
+    for opt in $KCI_KCONFIGS_MODULE; do
+        ../scripts/config --file .config --module CONFIG_$opt
+    done
+
+    if [ -n "$KCI_KCONFIGS_DISABLE" ] || [ -n "$KCI_KCONFIGS_ENABLE" ] ||
+       [ -n "$KCI_KCONFIGS_MODULE" ]; then
+        # execude olddefconfig only if we changed the default config, otherwise,
+        # let it raise warnings if any
+        make -C "$ICI_KERNEL_DIR" O=$(pwd) olddefconfig
+    fi
+
+    popd
+}
+
+ici_get_patch_series_size()
+{
+    local CLONE_DEPTH
+    CLONE_DEPTH=$(git rev-list --count HEAD)
+    echo "The depth of the clone is $CLONE_DEPTH"
+
+    # If this is in the context of a merge request, calculate the patch series
+    # size comparing to the target branch
+    if [ -n "$CI_MERGE_REQUEST_IID" ]; then
+        git fetch origin "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" --depth $CLONE_DEPTH
+        BASE_COMMIT="origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME"
+        ICI_PATCH_SERIES_SIZE=$(git rev-list --count ${BASE_COMMIT}.."$CI_COMMIT_SHA")
+
+    # if KCI_PATCH_SERIES_SIZE is set, use it
+    elif [ -n "$KCI_PATCH_SERIES_SIZE" ]; then
+        ICI_PATCH_SERIES_SIZE="$KCI_PATCH_SERIES_SIZE"
+    else
+        ICI_PATCH_SERIES_SIZE=1
+        echo "WARNING: unable to detect the patch series size, using the default value of 1."
+        # shellcheck disable=SC2034
+        ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE=true
+    fi
+
+    # Check if the clone depth is smaller than or equal to KCI_PATCH_SERIES_SIZE,
+    # otherwise the checkpatch.pl hangs
+    if [ "$ICI_PATCH_SERIES_SIZE" -ge "$CLONE_DEPTH" ]; then
+        echo -n "ERROR: the depth of the clone is $CLONE_DEPTH, smaller than or equal to the patch"
+        echo " series size. Update your GitLab configuration to increase the size of the clone."
+        return 1
+    fi
+}
diff --git a/tools/ci/gitlab-ci/ci-scripts/install-smatch.sh b/tools/ci/gitlab-ci/ci-scripts/install-smatch.sh
new file mode 100755
index 000000000000..cae16a0e90fa
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/install-smatch.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+pushd /
+git clone --depth 1 https://repo.or.cz/smatch.git
+pushd smatch
+make
+popd
+popd
diff --git a/tools/ci/gitlab-ci/ci-scripts/parse_commit_message.sh b/tools/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
new file mode 100755
index 000000000000..c9792c64ad51
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+# Get the last commit message
+commit_message=$(git log -1 --pretty=%B)
+
+pattern='(KCI_[A-Za-z_]+)=("[^"]*"|[^ ]+)'
+
+while read -r line; do
+    if [[ $line =~ $pattern ]]; then
+        variable_name="${BASH_REMATCH[1]}"
+        variable_value="${BASH_REMATCH[2]}"
+
+        # Remove quotes if present
+        variable_value="${variable_value%\"}"
+        variable_value="${variable_value#\"}"
+
+        # Export the variable
+        export "$variable_name=$variable_value"
+
+        echo "Exported $variable_name=$variable_value"
+    fi
+done <<< "$commit_message"
diff --git a/tools/ci/gitlab-ci/ci-scripts/run-checkpatch.sh b/tools/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
new file mode 100755
index 000000000000..dedcb3134141
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_get_patch_series_size
+
+# shellcheck disable=SC2086
+scripts/checkpatch.pl $KCI_CHECKPATCH_OPTIONS --git HEAD-"$ICI_PATCH_SERIES_SIZE"
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the whole series."
+    echo " Exiting with a warning."
+    exit 101
+fi
diff --git a/tools/ci/gitlab-ci/ci-scripts/run-smatch.sh b/tools/ci/gitlab-ci/ci-scripts/run-smatch.sh
new file mode 100755
index 000000000000..c112dbee39c4
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/run-smatch.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source tools/ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ls -l
+pwd
+
+# generate config file
+ici_prepare_build
+
+ici_get_patch_series_size
+
+cp build/.config .
+
+# Get a list of modified .c files in the last ICI_PATCH_SERIES_SIZE commits
+MODIFIED_C_FILES=$(git diff --name-only HEAD~$ICI_PATCH_SERIES_SIZE HEAD | grep '\.c$' || true)
+
+# Check if any .c files were modified
+if [ -z "$MODIFIED_C_FILES" ]; then
+    echo "No .c files were modified in the last $ICI_PATCH_SERIES_SIZE commits."
+else
+    echo "Running kchecker on modified .c files..."
+    mkdir -p "$CI_PROJECT_DIR"/artifacts
+fi
+
+# Run kchecker on each modified .c file
+for file in $MODIFIED_C_FILES; do
+    if [ -f "$file" ]; then
+        /smatch/smatch_scripts/kchecker "$file" | tee "$CI_PROJECT_DIR"/artifacts/smatch_warns.txt
+    else
+        echo "File not found: $file"
+    fi
+done
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the whole series."
+    echo " Exiting with a warning."
+    exit 101
+fi
diff --git a/tools/ci/gitlab-ci/ci-scripts/run-virtme.sh b/tools/ci/gitlab-ci/ci-scripts/run-virtme.sh
new file mode 100755
index 000000000000..e752ed3689c7
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/run-virtme.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the virtme-run.sh script from the Mutter project:
+# https://gitlab.gnome.org/GNOME/mutter/-/blob/main/src/tests/kvm/virtme-run.sh
+#
+# Run tests in a virtual machine using virtme-ng.
+#
+# $1: A Linux kernel image
+# $2: Test script to run
+# $3: Environment Variables
+
+set -e
+
+IMAGE="$1"
+SCRIPT="$2"
+VM_ENV="$3"
+
+TEST_RESULT_FILE=$(mktemp -p "/tmp" test-result-XXXXXX)
+echo 1 > "$TEST_RESULT_FILE"
+
+if [ -n "$VM_ENV" ]; then
+  SCRIPT="env $VM_ENV $SCRIPT \\\"$TEST_RESULT_FILE\\\""
+else
+  SCRIPT="$SCRIPT \\\"$TEST_RESULT_FILE\\\""
+fi
+
+echo Running tests in virtual machine ...
+virtme-run \
+  --mods=auto \
+  --memory=1024M \
+  --rw \
+  --pwd \
+  --kimg "$IMAGE" \
+  --script-sh "sh -c \"$SCRIPT\"" \
+  --show-command \
+  --verbose --show-boot-console \
+  --qemu-opts -cpu host,pdcm=off -smp $(nproc)
+VM_RESULT=$?
+if [ $VM_RESULT != 0 ]; then
+  echo Virtual machine exited with a failure: $VM_RESULT
+else
+  echo Virtual machine terminated.
+fi
+TEST_RESULT="$(cat "$TEST_RESULT_FILE")"
+
+echo Test result exit status: $TEST_RESULT
+
+rm "$TEST_RESULT_FILE"
+exit "$TEST_RESULT"
diff --git a/tools/ci/gitlab-ci/ci-scripts/test-boot.sh b/tools/ci/gitlab-ci/ci-scripts/test-boot.sh
new file mode 100755
index 000000000000..1afe3483b5e8
--- /dev/null
+++ b/tools/ci/gitlab-ci/ci-scripts/test-boot.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+set -ex
+
+STATUS_FILE="${1}"
+
+uname -a
+ret=$?
+
+echo $ret > ${STATUS_FILE}
+exit $ret
diff --git a/tools/ci/gitlab-ci/container.yml b/tools/ci/gitlab-ci/container.yml
new file mode 100644
index 000000000000..2108a39d5a9c
--- /dev/null
+++ b/tools/ci/gitlab-ci/container.yml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+include:
+  - local: 'tools/ci/gitlab-ci/arm_native_compile.yml'
+    rules:
+      - if: '$CI_SERVER_HOST == "gitlab.freedesktop.org"'
+  - local: 'tools/ci/gitlab-ci/arm_cross_compile.yml'
+    rules:
+      - if: '$CI_SERVER_HOST != "gitlab.freedesktop.org"'
+
+variables:
+  FDO_REPO_SUFFIX: "$BUILD_OS/$KCI_BUILD_ARCH"
+  FDO_DISTRIBUTION_TAG: "2025-01-21-debian"
+  FDO_DISTRIBUTION_EXEC: ./tools/ci/gitlab-ci/ci-scripts/install-smatch.sh
+
+.debian:
+  variables:
+    BUILD_OS: debian
+    FDO_DISTRIBUTION_VERSION: trixie-slim
+    FDO_DISTRIBUTION_PACKAGES: >-
+      bc
+      binutils-aarch64-linux-gnu
+      binutils-arm-linux-gnueabihf
+      bison
+      build-essential
+      ccache
+      curl
+      dvipng
+      flex
+      fonts-noto-cjk
+      gcc-aarch64-linux-gnu
+      gcc-arm-linux-gnueabihf
+      git
+      graphviz
+      imagemagick
+      kmod
+      latexmk
+      libcairo-dev
+      libdbd-sqlite3-perl
+      libdrm-dev
+      libdw-dev
+      libjson-c-dev
+      libkmod2
+      libkmod-dev
+      libpciaccess-dev
+      libproc2-dev
+      librsvg2-bin
+      libsqlite3-dev
+      libssl-dev
+      libtry-tiny-perl
+      libudev-dev
+      libunwind-dev
+      make
+      meson
+      mount
+      pahole
+      perl
+      python3-docutils
+      python3-dulwich
+      python3-git
+      python3-ply
+      python3-sphinx
+      python3-venv
+      python3-yaml
+      sqlite3
+      texlive-lang-chinese
+      texlive-xetex
+      udev
+      virtme-ng
+
+.x86_64-config:
+  variables:
+    KCI_KERNEL_ARCH: "x86_64"
+    KCI_DEFCONFIG: "x86_64_defconfig"
+    KCI_KERNEL_IMAGE_NAME: "bzImage"
+
+.arm64-config:
+  variables:
+    KCI_KERNEL_ARCH: "arm64"
+    KCI_DEFCONFIG: "defconfig"
+    KCI_KERNEL_IMAGE_NAME: "Image"
+
+.arm32-config:
+  variables:
+    KCI_KERNEL_ARCH: "arm"
+    KCI_DEFCONFIG: "multi_v7_defconfig"
+    KCI_KERNEL_IMAGE_NAME: "zImage"
+
+.debian-x86_64:
+  extends:
+    - .debian
+  variables:
+    KCI_BUILD_ARCH: "x86-64"
+
+.debian-arm64:
+  extends:
+    - .debian
+  variables:
+    KCI_BUILD_ARCH: "arm64"
+
+debian/x86_64_build:
+  extends:
+    - .debian-x86_64
+    - .fdo.container-build@debian
+  stage: container
+
+.use-debian/x86_64_build:
+  extends:
+    - .debian-x86_64
+    - .fdo.suffixed-image@debian
+  needs:
+    - job: debian/x86_64_build
diff --git a/tools/ci/gitlab-ci/docker-compose.yaml b/tools/ci/gitlab-ci/docker-compose.yaml
new file mode 100644
index 000000000000..7edf8055ca37
--- /dev/null
+++ b/tools/ci/gitlab-ci/docker-compose.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+version: '3.8'
+
+services:
+  gitlab-runner:
+    image: gitlab/gitlab-runner:latest
+    container_name: gitlab-runner
+    restart: always
+    privileged: true
+    volumes:
+      - /srv/gitlab-runner/config:/etc/gitlab-runner
+      - /var/run/docker.sock:/var/run/docker.sock
+
+# To register the GitLab Runner, run the following command:
+# docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register --url https://gitlab.com --token YOUR_REGISTRATION_TOKEN
diff --git a/tools/ci/gitlab-ci/gitlab-ci.yml b/tools/ci/gitlab-ci/gitlab-ci.yml
new file mode 100644
index 000000000000..d2679d9929de
--- /dev/null
+++ b/tools/ci/gitlab-ci/gitlab-ci.yml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+workflow:
+  name: $PIPELINE_NAME
+  rules:
+    # when triggered as a multi-project pipeline for an MR
+    - if: $CI_PIPELINE_SOURCE == 'pipeline' && $PARENT_MERGE_REQUEST_IID != null && $PARENT_MERGE_REQUEST_IID != ""
+      variables:
+        PIPELINE_NAME: 'Downstream pipeline for $PARENT_PROJECT_PATH!$PARENT_MERGE_REQUEST_IID'
+    # when triggered as a multi-project pipeline
+    - if: $CI_PIPELINE_SOURCE == 'pipeline'
+      variables:
+        PIPELINE_NAME: 'Downstream pipeline for $PARENT_PROJECT_PATH'
+    # when triggered via a schedule
+    - if: $CI_PIPELINE_SOURCE == 'schedule'
+      variables:
+        PIPELINE_NAME: 'Scheduled pipeline for $ONLY_JOB_NAME'
+    # for merge requests
+    - if: $CI_MERGE_REQUEST_ID
+    # when triggered via the REST api
+    - if: $CI_PIPELINE_SOURCE == 'api'
+    # for the tip of the default branch
+    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
+    # when triggered via a trigger token
+    - if: $CI_PIPELINE_SOURCE == 'trigger'
+    # when triggered from a button press in the web interface
+    - if: $CI_PIPELINE_SOURCE == 'web'
+    # for branch tips without open MRs, ignoring special branches
+    - if: $CI_PIPELINE_SOURCE == 'push' && $CI_OPEN_MERGE_REQUESTS == null
+    # when forced via '-o ci.variable="FORCE_CI=true"' during pushing
+    - if: $FORCE_CI == 'true'
+
+variables:
+  SMATCH_DB_DIR: /smatch/smatch_data
+  # exit code of bash script on `script` will be the exit code of the job
+  FF_USE_NEW_BASH_EVAL_STRATEGY: "true"
+  KCI_SCENARIO:
+    description: Set to any non-empty value to disable scenarios
+    value: ""
+
+default:
+  artifacts:
+    paths:
+      - artifacts/
+    when: always
+
+include:
+  - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/debian.yml'
+
+  - tools/ci/gitlab-ci/container.yml
+  - tools/ci/gitlab-ci/cache.yml
+  - tools/ci/gitlab-ci/build.yml
+  - tools/ci/gitlab-ci/test.yml
+  - tools/ci/gitlab-ci/static-checks.yml
+  - tools/ci/gitlab-ci/scenarios.yml
+
+before_script:
+  - source tools/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
+
+.use-debian/x86_64_build:
+  allow_failure:
+    # Code to exit with a warning
+    exit_codes: 101
+
+stages:
+  - container
+  - static-checks
+  - build
+  - test
+  - cache
diff --git a/tools/ci/gitlab-ci/scenarios.yml b/tools/ci/gitlab-ci/scenarios.yml
new file mode 100644
index 000000000000..8363da24133f
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios.yml
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Extend the CI by including a test scenario here. The scenario will be
+# activated if KCI_SCENARIO is set to the scenario name. KCI_SCENARIO can be
+# defined in the gitlab-ci.yml file, or through GitLab UI.
+
+include:
+  - local: 'tools/ci/gitlab-ci/scenarios/$KCI_SCENARIO/$KCI_SCENARIO.yml'
+    rules:
+      - if: '$KCI_SCENARIO'
+  - local: 'tools/ci/gitlab-ci/scenarios/$KCI_SCENARIO/test.yml'
+    rules:
+      - if: '$KCI_SCENARIO'
diff --git a/tools/ci/gitlab-ci/scenarios/drm/drm.yml b/tools/ci/gitlab-ci/scenarios/drm/drm.yml
new file mode 100644
index 000000000000..206e6f0d1a46
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/drm.yml
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# build:arm64:
+#   variables:
+#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+#     KCI_DEFCONFIG: "my/custom/config1"
diff --git a/tools/ci/gitlab-ci/scenarios/file-systems/file-systems.yml b/tools/ci/gitlab-ci/scenarios/file-systems/file-systems.yml
new file mode 100644
index 000000000000..206e6f0d1a46
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/file-systems/file-systems.yml
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# build:arm64:
+#   variables:
+#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+#     KCI_DEFCONFIG: "my/custom/config1"
diff --git a/tools/ci/gitlab-ci/scenarios/media/media.yml b/tools/ci/gitlab-ci/scenarios/media/media.yml
new file mode 100644
index 000000000000..206e6f0d1a46
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/media/media.yml
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# build:arm64:
+#   variables:
+#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+#     KCI_DEFCONFIG: "my/custom/config1"
diff --git a/tools/ci/gitlab-ci/scenarios/network/network.yml b/tools/ci/gitlab-ci/scenarios/network/network.yml
new file mode 100644
index 000000000000..206e6f0d1a46
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/network/network.yml
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# build:arm64:
+#   variables:
+#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+#     KCI_DEFCONFIG: "my/custom/config1"
diff --git a/tools/ci/gitlab-ci/static-checks.yml b/tools/ci/gitlab-ci/static-checks.yml
new file mode 100644
index 000000000000..656802fd8fb6
--- /dev/null
+++ b/tools/ci/gitlab-ci/static-checks.yml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.static-checks:
+  stage: static-checks
+  extends:
+    - .use-debian/x86_64_build
+    - .x86_64-config
+
+checkpatch:
+  extends: .static-checks
+  script:
+    - tools/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
+
+smatch:
+  extends:
+    - .static-checks
+    - .use-cache-smatch-db
+  script:
+    - tools/ci/gitlab-ci/ci-scripts/run-smatch.sh
diff --git a/tools/ci/gitlab-ci/test.yml b/tools/ci/gitlab-ci/test.yml
new file mode 100644
index 000000000000..e64ea36c1321
--- /dev/null
+++ b/tools/ci/gitlab-ci/test.yml
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+test-boot:
+  extends: build:x86_64
+  stage: test
+  timeout: "10m"
+  tags:
+    - kvm
+  script:
+    - mkdir -p /install
+    - cp $CI_PROJECT_DIR/artifacts/kernel-install-${KCI_KERNEL_ARCH}/bzImage /install/
+    - ./tools/ci/gitlab-ci/ci-scripts/run-virtme.sh /install/bzImage ./tools/ci/gitlab-ci/ci-scripts/test-boot.sh
+  needs:
+    - build:x86_64
-- 
2.43.0

