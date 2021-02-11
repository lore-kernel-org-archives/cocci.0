Return-Path: <SRS0=82Xq=HP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B8C433E0
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BDB64E29
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BDB64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11DLc68l017091;
	Sat, 13 Feb 2021 22:38:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9ABDE77E2;
	Sat, 13 Feb 2021 22:38:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 89AC974AF
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:49 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BNRmqA012322
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 00:27:49 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id i20so6842901otl.7
 for <cocci@systeme.lip6.fr>; Thu, 11 Feb 2021 15:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NMJ7yLd9O23CBO6jbidyP4gLEKA1R1vMVgKZt27Rrho=;
 b=J6XUW0TzIy5gxVicHg9K9zwGE7+8jC22rfmZvz+DbKNPQca73V7cpCq+lNsd+M5BGO
 33+LiuPFs+bXv8UfEPmnv3GSQqZfpAMa+cVgZMtCE8Qz3WXxlchITrC3uJXgo7qKb8jC
 tbyR1yl3qWlM098zsBygI675e9FTZh2BUB/ckvetZvaooAFDYyqwtXNPoStXo9TM0Amr
 CM0rVScktxDgG69gwi3FZXiLlVQ7XXl3IeENOdsI4bVYUAqW+3/cgNVVa1xp67xSOOCL
 tKIm4YltFUDkM8ySqnEdxiVt2u/DpDQHpHlfkxOMclsBeSWjiG0G+eJV60F2mYz35Z03
 /jqA==
X-Gm-Message-State: AOAM533rk6hMXVxL1jnF7Fn5Xi3fSNkF7qJ4jbXVPZKkMUt0l1R4vwkl
 3MbkfCScM36CknTWgdnIDw==
X-Google-Smtp-Source: ABdhPJxCLDZrG4wjSzEe3ksZoou3d9Y2oSOGUfFU4jjPmhV2WnoDeeXu5PQ90Om+6OiCd4FYz8Tnog==
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr250282otl.369.1613086068486;
 Thu, 11 Feb 2021 15:27:48 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id s18sm1283922oih.53.2021.02.11.15.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 15:27:47 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Date: Thu, 11 Feb 2021 17:27:43 -0600
Message-Id: <20210211232745.1498137-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 22:38:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Feb 2021 00:27:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 13 Feb 2021 22:38:04 +0100
Cc: Felipe Balbi <balbi@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
        linux-arm-kernel@lists.infradead.org
Subject: [Cocci] [PATCH v2 0/2] of: of_device.h cleanups
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a couple of cleanups for of_device.h. They fell out from my
attempt at decoupling of_device.h and of_platform.h which is a mess
and I haven't finished, but there's no reason to wait on these.

Rob

Rob Herring (2):
  of: Remove of_dev_{get,put}()
  driver core: platform: Drop of_device_node_put() wrapper

 arch/powerpc/platforms/pseries/ibmebus.c |  4 ++--
 drivers/base/platform.c                  |  2 +-
 drivers/net/ethernet/ibm/emac/core.c     | 15 ++++++++-------
 drivers/of/device.c                      | 21 ---------------------
 drivers/of/platform.c                    |  4 ++--
 drivers/of/unittest.c                    |  2 +-
 drivers/usb/dwc3/dwc3-st.c               |  2 +-
 include/linux/of_device.h                | 10 ----------
 scripts/coccinelle/free/put_device.cocci |  1 -
 9 files changed, 15 insertions(+), 46 deletions(-)

-- 
2.27.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
