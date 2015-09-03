From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 3 Sep 2015 03:24:44 +0200
Subject: [Cocci] [PATCH] Makefile: fix autotools pre ./configure version
 regression
In-Reply-To: <1441243250-23830-1-git-send-email-mcgrof@do-not-panic.com>
References: <1441243250-23830-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <20150903012444.GN8051@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Sep 02, 2015 at 06:20:50PM -0700, Luis R. Rodriguez wrote:
> +VERSION?=$(shell MAKE_COCCI_RELEASE="y" ./version.sh)

To be clear usage of

FOO ?= bar

is equivalent to using:

ifeq ($(origin FOO), undefined)
  FOO = bar
endif

So once the user has run ./configure the right version will be set.

https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors

  Luis
