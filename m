Return-Path: <SRS0=ECaW=GD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954CC433DB
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 22:41:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280C820888
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 22:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280C820888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVMeuoL012635;
	Thu, 31 Dec 2020 23:40:56 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 463BE3A53;
	Thu, 31 Dec 2020 23:40:56 +0100 (CET)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B98AC373F
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 23:40:54 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0067.hostedemail.com
 [216.40.44.67])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0BVMeqBZ024782
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 23:40:53 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 23A348124328
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 20:13:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id B12311802926E;
 Thu, 31 Dec 2020 20:13:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: whip41_03007be274b0
X-Filterd-Recvd-Size: 4970
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf17.hostedemail.com (Postfix) with ESMTPA;
 Thu, 31 Dec 2020 20:13:31 +0000 (UTC)
Message-ID: <cc5722eb472a0a94f3418f6081b10f3c4a7e156d.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Date: Thu, 31 Dec 2020 12:13:30 -0800
In-Reply-To: <58a84d03b714f71d231f9cac04af09a6b97c6f04.camel@perches.com>
References: <58a84d03b714f71d231f9cac04af09a6b97c6f04.camel@perches.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Dec 2020 23:40:56 +0100 (CET)
X-Greylist: Delayed for 02:27:18 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Thu, 31 Dec 2020 23:40:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>
Subject: [Cocci] cocci: missed strlcpy->strscpy conversion?
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

On Thu, 2020-12-31 at 11:04 -0800, Joe Perches wrote:
> strlcpy is deprecated.  see: Documentation/process/deprecated.rst
> 
> Change the calls that do not use the strlcpy return value to the
> preferred strscpy.
> 
> Done with cocci script:
> 
> @@
> expression e1, e2, e3;
> @@
> 
> -	strlcpy(
> +	strscpy(
> 	e1, e2, e3);
> 
> This cocci script leaves the instances where the return value is
> used unchanged.

Hey Julia.

After using the cocci script above on a test treewide conversion,
there were a few instances with no return use that were not converted.

Any idea why these were not converted?
I don't see a pattern.

The .h files may be because those are the only uses in .h files in the kernel
but drivers/block/rnbd/rnbd-clt.c I don't understand at all.

drivers/block/rnbd/rnbd-clt.c:  strlcpy(sess->sessname, sessname, sizeof(sess->sessname));
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(dst, "PNP:", dst_size);
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h:      strlcpy(buf, bp->acquire_resp.pfdev_info.fw_ver, buf_len);

$ git grep -3 strlcpy drivers/block/rnbd/rnbd-clt.c drivers/input/serio/i8042-x86ia64io.h drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
drivers/block/rnbd/rnbd-clt.c-  sess = kzalloc_node(sizeof(*sess), GFP_KERNEL, NUMA_NO_NODE);
drivers/block/rnbd/rnbd-clt.c-  if (!sess)
drivers/block/rnbd/rnbd-clt.c-          return ERR_PTR(-ENOMEM);
drivers/block/rnbd/rnbd-clt.c:  strlcpy(sess->sessname, sessname, sizeof(sess->sessname));
drivers/block/rnbd/rnbd-clt.c-  atomic_set(&sess->busy, 0);
drivers/block/rnbd/rnbd-clt.c-  mutex_init(&sess->lock);
drivers/block/rnbd/rnbd-clt.c-  INIT_LIST_HEAD(&sess->devs_list);
--
drivers/input/serio/i8042-x86ia64io.h-
drivers/input/serio/i8042-x86ia64io.h-static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
drivers/input/serio/i8042-x86ia64io.h-{
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(dst, "PNP:", dst_size);
drivers/input/serio/i8042-x86ia64io.h-
drivers/input/serio/i8042-x86ia64io.h-  while (id) {
drivers/input/serio/i8042-x86ia64io.h-          strlcat(dst, " ", dst_size);
--
drivers/input/serio/i8042-x86ia64io.h-  if (pnp_irq_valid(dev,0))
drivers/input/serio/i8042-x86ia64io.h-          i8042_pnp_kbd_irq = pnp_irq(dev, 0);
drivers/input/serio/i8042-x86ia64io.h-
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
drivers/input/serio/i8042-x86ia64io.h-  if (strlen(pnp_dev_name(dev))) {
drivers/input/serio/i8042-x86ia64io.h-          strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
drivers/input/serio/i8042-x86ia64io.h-          strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
--
drivers/input/serio/i8042-x86ia64io.h-  if (pnp_irq_valid(dev, 0))
drivers/input/serio/i8042-x86ia64io.h-          i8042_pnp_aux_irq = pnp_irq(dev, 0);
drivers/input/serio/i8042-x86ia64io.h-
drivers/input/serio/i8042-x86ia64io.h:  strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
drivers/input/serio/i8042-x86ia64io.h-  if (strlen(pnp_dev_name(dev))) {
drivers/input/serio/i8042-x86ia64io.h-          strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
drivers/input/serio/i8042-x86ia64io.h-          strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
--
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-static inline void bnx2x_vf_fill_fw_str(struct bnx2x *bp, char *buf,
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-                                      size_t buf_len)
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-{
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h:      strlcpy(buf, bp->acquire_resp.pfdev_info.fw_ver, buf_len);
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-}
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-
drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h-static inline int bnx2x_vf_ustorm_prods_offset(struct bnx2x *bp,

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
