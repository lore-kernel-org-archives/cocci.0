Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12754C0218C
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=r/kyJpgZpTkKzsg+BNVYdElJ1Zu4zv8KVO1nd6AdTc4=;
  b=pJMWEbJhlG9JuQy33mhOgAYkZXkyYUkuFbancnmYGl1Ok69Muiq4+PAm
   X9d2W3/hSeft050RJVRQUC2e2phayaNu8MhHPi28781KKLRxMLWoIN4G4
   H3p+QaucYffc7bt9rN4zkipwAUhHUn6whDGV4tsLEYE88cYgkCH40WzS9
   0=;
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
   d="scan'208";a="205238234"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 247E3E0D3B; Mon, 27 Jan 2025 17:17:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B6F6E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:54:24 +0100 (CET)
IronPort-SDR: 67924a07_xOJ74/16Kj8BRUNCHTCbte/zTHx6UwxDcBLh0f1OFDlZuUF
 C3iPGKFW03kbYQx7pmRz9lIfTeHJPf7qdqBNr4g==
X-IPAS-Result: =?us-ascii?q?A0EWAADRSZJnhcNp+5RaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkN9WjMEC0gEiCGETocxgiGBfJwfgX4PAQMBDTQNAQIEAQEDAQOEO?=
 =?us-ascii?q?kaKdgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmFew2CWztxgSUBAQEBAQEBAQEBAQEBHQIIBV4BASArCwENAQE3AYFHC?=
 =?us-ascii?q?BqCZwGCZAIBBQwGuCAzgQGCDAEBBoEIDkIDDy/aBoFkCYFIAYVqh19wg316J?=
 =?us-ascii?q?w+BVUSBFYJ5b4JhAQKII4N4LYFYXoEMhmaFZ3Q7gxKEZ4oUSIEhA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBcQM4DAswFYFJRDeCR2lJOgINAjWCHnyCK4RehEWEUYVbghSCFII2g?=
 =?us-ascii?q?ylAAwsYDUgRLDcUGwY+bgecFj2DBD41ATwkLQEpAoI9OpJUEoMpjnugUjQHh?=
 =?us-ascii?q?B6BXQYMiQeBIpUuTYQEjQaGRpMDmHyCWIkzgXmVUIUoMYFnOoErHgwHMxojg?=
 =?us-ascii?q?wMBATIJCjwDGQ+OIQkQCYNYhRSBPbokOzUCAQE4AgcLAQEDCYVFAQEBO4lhL?=
 =?us-ascii?q?QWBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 WzfHwOw3oxd5pDfVWbFdT7kbW+YxM9nxvSHEZI=
IronPort-HdrOrdr: A9a23:WTEILqFWORTCcp58pLqE+ceALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG+c5x6faaslcssR0b9OxoW5PwI080l6QU3WB5B97LNjUO01HHEGgN1+ffKkXbak7DytI=
X-Talos-CUID: 9a23:uOlz1mBhYY233I76ExZO+EM+FZALSy2eynL/LUKlGH1Ab6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AU2eKrg79DhyT0uHJ2bFE0+kDxoxazbWUJmsskaw?=
 =?us-ascii?q?HpsavJwpLFA+ai2SOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204665562"
X-MGA-submission: =?us-ascii?q?MDENuY36k/qkZFO7miMGwMT+rHzHFFTm/LKOD5?=
 =?us-ascii?q?UOxtEVYaaxI+W06m2CMhOn6LsqiyeD/OxO+ZKWBH5Y8yjnXQWz/c0rlt?=
 =?us-ascii?q?mqfh+adwOiAUdleJq6k713vKvVjNxP5cZw7cTT+LRliOT6qoBqduckfF?=
 =?us-ascii?q?OhDLAjLdk7jPcAO97i/3jKTg=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:54:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640454;
	bh=2zVRnMaSJGa8LPDpFqfUhB6l5SHiGscWU+i1noCJMck=;
	h=From:To:Cc:Subject:Date:From;
	b=MzOqUGTqTtOu1XkXVBsK982ZUuFeBOVTHVTcYUGCYrUS2MtFRISD90nSR1mAGDgYv
	 YFHetiBL+85BvKZYGmBpszQglAvnNeefDEy8MvQ2AsC1tU4i2d2xWq4FLPE4jZcPnx
	 sbaogNwpDwmM+vZg108eOSWVL18btstIuSCEIIgVk9L7QXNK7eTlQ7t8hge1Nj3O6P
	 ZU88A7vnQ/8NmA2tlTXsyxtOnJ7U4QJa2YALHJl2LMmif7+aRdfILNP26McoE/u0n7
	 aI8l82An7t8D07M+CMZVvHSRgfG7oGCisRdwnzG5RaFlq7Vl7zgHCsg+MOuJiYMe4S
	 x24l0uqr4YSpA==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8297517E0E48;
	Thu, 23 Jan 2025 14:53:57 +0100 (CET)
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
Date: Thu, 23 Jan 2025 19:23:30 +0530
Message-ID: <20250123135342.1468787-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline
 for Kernel Testing
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2226
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250123135342.1468787-1-vignesh.raman%40collabora.com>

This patch series introduces "kci-gitlab," a GitLab CI pipeline
specifically designed for kernel testing. It provides kernel
developers with an integrated, efficient, and flexible testing
framework using GitLab's CI/CD capabilities. This patch includes
a .gitlab-ci file in the tools/ci/gitlab-ci/ folder, along with
additional YAML and script files, to define a basic test pipeline
triggered by code pushes to a GitLab-CI instance.
The initial version implements:
    
- Static checks: Includes checkpatch and smatch for code validation.
- Build tests: Covers various architectures and configurations.
- Boot tests: Utilizes virtme for basic boot testing.

Additionally, it introduces a flexible "scenarios" mechanism to
support subsystem-specific extensions.

This series also introduces a drm scenario that adds a job to run IGT
tests for vkms. This scenario includes helper scripts to build deqp-runner
and IGT, leveraging approaches from the drm-ci/mesa-ci project.

We are working towards creating a generic, upstream GitLab-CI pipeline
(kci-gitlab) that will replace DRM-CI [1]. The proposed GitLab-CI pipeline
is designed with a distributed infrastructure model, making it possible
to run on any gitLab instance. We plan to leverage KernelCI [2] as the
backend, utilizing its hardware, rootfs, test plans, and KCIDB [3]
integration.

For an example of a fully executed pipeline with drm scenario set,
including documentation generation,
see: https://gitlab.freedesktop.org/vigneshraman/kernel/-/pipelines/1350262

Please refer to the documentation included in the patch, or check the
rendered version, here: 
https://vigneshraman.pages.freedesktop.org/-/kernel/-/jobs/69787927/artifacts/artifacts/Documentation-output/ci/gitlab-ci/gitlab-ci.html

Differences from v1 to v2:
- moved to tools/ci as suggested by Linus on the previous version
- add arm64 containers for native compilation
- added boot tests using virtme: this is the base structure for boot tests,
  next steps would be adding other tests such as kselftests/kunit tests
- added DRM scenario testing on vkms: this should replace current vkms test
  in drm-ci. This work shows how a test scenario can be used by different
  subsystems to add their tests.
- update documentation

For more details on the motivation behind this work, please refer to the
cover letter of v1: https://patchwork.kernel.org/project/linux-kselftest/cover/20240228225527.1052240-1-helen.koike@collabora.com/

[1] https://www.collabora.com/news-and-blog/blog/2024/02/08/drm-ci-a-gitlab-ci-pipeline-for-linux-kernel-testing/
[2] https://kernelci.org/
[3] https://docs.kernelci.org/kcidb/

Helen Koike (3):
  kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
  kci-gitlab: Add documentation
  kci-gitlab: docs: Add images

Vignesh Raman (2):
  MAINTAINERS: Add an entry for ci automated testing
  kci-gitlab: Add drm scenario

 Documentation/ci/gitlab-ci/gitlab-ci.rst      | 471 ++++++++++
 .../ci/gitlab-ci/images/drm-vkms.png          | Bin 0 -> 73810 bytes
 .../ci/gitlab-ci/images/job-matrix.png        | Bin 0 -> 20000 bytes
 .../gitlab-ci/images/new-project-runner.png   | Bin 0 -> 607737 bytes
 .../ci/gitlab-ci/images/pipelines-on-push.png | Bin 0 -> 532143 bytes
 .../ci/gitlab-ci/images/the-pipeline.png      | Bin 0 -> 62464 bytes
 .../ci/gitlab-ci/images/variables.png         | Bin 0 -> 277518 bytes
 Documentation/index.rst                       |   7 +
 MAINTAINERS                                   |  10 +
 tools/ci/gitlab-ci/arm_cross_compile.yml      |   9 +
 tools/ci/gitlab-ci/arm_native_compile.yml     |  20 +
 tools/ci/gitlab-ci/bootstrap-gitlab-runner.sh |  55 ++
 tools/ci/gitlab-ci/build.yml                  |  43 +
 tools/ci/gitlab-ci/cache.yml                  |  24 +
 tools/ci/gitlab-ci/ci-scripts/build-docs.sh   |  35 +
 tools/ci/gitlab-ci/ci-scripts/build-kernel.sh |  43 +
 .../ci/gitlab-ci/ci-scripts/ici-functions.sh  | 106 +++
 .../ci/gitlab-ci/ci-scripts/install-smatch.sh |  13 +
 .../ci-scripts/parse_commit_message.sh        |  27 +
 .../ci/gitlab-ci/ci-scripts/run-checkpatch.sh |  20 +
 tools/ci/gitlab-ci/ci-scripts/run-smatch.sh   |  45 +
 tools/ci/gitlab-ci/ci-scripts/run-virtme.sh   |  52 ++
 tools/ci/gitlab-ci/ci-scripts/test-boot.sh    |  14 +
 tools/ci/gitlab-ci/container.yml              | 114 +++
 tools/ci/gitlab-ci/docker-compose.yaml        |  18 +
 tools/ci/gitlab-ci/gitlab-ci.yml              |  72 ++
 tools/ci/gitlab-ci/scenarios.yml              |  15 +
 .../scenarios/drm/build-deqp-runner.sh        |  42 +
 tools/ci/gitlab-ci/scenarios/drm/build-igt.sh |  80 ++
 .../ci/gitlab-ci/scenarios/drm/build-rust.sh  |  42 +
 .../scenarios/drm/create-cross-file.sh        |  65 ++
 tools/ci/gitlab-ci/scenarios/drm/drm.yml      |  44 +
 .../scenarios/drm/prepare-container.sh        |  18 +
 tools/ci/gitlab-ci/scenarios/drm/run-igt.sh   |  83 ++
 tools/ci/gitlab-ci/scenarios/drm/test.yml     |  32 +
 .../scenarios/drm/xfails/vkms-none-fails.txt  |  22 +
 .../scenarios/drm/xfails/vkms-none-flakes.txt |  90 ++
 .../scenarios/drm/xfails/vkms-none-skips.txt  | 812 ++++++++++++++++++
 .../scenarios/file-systems/file-systems.yml   |  11 +
 tools/ci/gitlab-ci/scenarios/media/media.yml  |  11 +
 .../gitlab-ci/scenarios/network/network.yml   |  11 +
 tools/ci/gitlab-ci/static-checks.yml          |  21 +
 tools/ci/gitlab-ci/test.yml                   |  16 +
 43 files changed, 2613 insertions(+)
 create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst
 create mode 100644 Documentation/ci/gitlab-ci/images/drm-vkms.png
 create mode 100644 Documentation/ci/gitlab-ci/images/job-matrix.png
 create mode 100644 Documentation/ci/gitlab-ci/images/new-project-runner.png
 create mode 100644 Documentation/ci/gitlab-ci/images/pipelines-on-push.png
 create mode 100644 Documentation/ci/gitlab-ci/images/the-pipeline.png
 create mode 100644 Documentation/ci/gitlab-ci/images/variables.png
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
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-igt.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-rust.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/drm.yml
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/run-igt.sh
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/test.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt
 create mode 100644 tools/ci/gitlab-ci/scenarios/file-systems/file-systems.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/media/media.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/network/network.yml
 create mode 100644 tools/ci/gitlab-ci/static-checks.yml
 create mode 100644 tools/ci/gitlab-ci/test.yml

-- 
2.43.0

