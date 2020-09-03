Return-Path: <SRS0=mXBt=CM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D83C433E2
	for <cocci@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7444320716
	for <cocci@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7444320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08371IMg014549;
	Thu, 3 Sep 2020 09:01:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4665E742E;
	Thu,  3 Sep 2020 09:01:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 578386717
 for <cocci@systeme.lip6.fr>; Thu,  3 Sep 2020 09:01:17 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0245.hostedemail.com
 [216.40.44.245])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 08371EfV010104
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 3 Sep 2020 09:01:15 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 729DF18008236
 for <cocci@systeme.lip6.fr>; Thu,  3 Sep 2020 07:01:13 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 31786181D3026;
 Thu,  3 Sep 2020 07:01:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean32_3214141270a7
X-Filterd-Recvd-Size: 6538
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf11.hostedemail.com (Postfix) with ESMTPA;
 Thu,  3 Sep 2020 07:01:07 +0000 (UTC)
Message-ID: <b9fb1726674df7bcf2ef7c18bb102956a9336063.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 03 Sep 2020 00:01:06 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009022338280.2460@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
 <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
 <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
 <alpine.DEB.2.22.394.2008301021250.3629@hadrien>
 <bc3215bbf6c217a06dc2ebbf6ddd977c5d57654c.camel@perches.com>
 <alpine.DEB.2.22.394.2008301742400.3629@hadrien>
 <7ce009d5f538feae7a6a20e0bbecdf73d74ea9f9.camel@perches.com>
 <alpine.DEB.2.22.394.2008302039000.3629@hadrien>
 <ec1cc3309738bf1acab87fcf9178dbf7b204176a.camel@perches.com>
 <alpine.DEB.2.22.394.2009022236330.2460@hadrien>
 <0db493cb85521ee26b7ca7c255e89721cc6b6dcd.camel@perches.com>
 <alpine.DEB.2.22.394.2009022338280.2460@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Sep 2020 09:01:18 +0200 (CEST)
X-Greylist: Delayed for 107:22:53 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 03 Sep 2020 09:01:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] transform oddity / bug ?
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

On Wed, 2020-09-02 at 23:38 +0200, Julia Lawall wrote:
> On Wed, 2 Sep 2020, Joe Perches wrote:
> > On Wed, 2020-09-02 at 22:46 +0200, Julia Lawall wrote:
> > > On Wed, 2 Sep 2020, Joe Perches wrote:
> > > > On Sun, 2020-08-30 at 20:41 +0200, Julia Lawall wrote:
> > > > > On Sun, 30 Aug 2020, Joe Perches wrote:
> > > > > > On Sun, 2020-08-30 at 17:46 +0200, Julia Lawall wrote:
> > > > > > > Unfortunately this does not work when the declaration
> > > > > > is comma terminated and not semicolon terminated.
> > > > []
> > > > > I will have to look into it.  It should handle this sort of thing, but it
> > > > > is somewhat complex, because the declarations have to be split and this
> > > > > specific case may not be handled.
> > > > 
> > > > Thanks.  Hope you can get to look at that one day.
> > > > 
> > > > > One thing that is possible is to change only the variable name.  If there
> > > > > are not many occurrences, one could fix them up afterwards by hand.
> > > > 
> > > > And hi again Julia.
> > > > 
> > > > I've tried a few variations on finding uses of a function
> > > > argument that are not by specific named functions or with
> > > > local assignment of that function argument to another
> > > > variable without success.
> > > > 
> > > > For example:
> > > > 
> > > > ssize_t fn(struct device *dev, struct device_attribute *attr, char *buf)
> > > > {
> > > > *	char *orig = buf;
> > > > or
> > > > 	int count;
> > > > ...
> > > > *	count = local_static_func(some_struct *foo, buf);
> > > > }
> > > > 
> > > > where local_static_func is not sysfs_emit or sysfs_emit_at
> > > > 
> > > > Any clue you can offer?
> > > 
> > > I'm not completely sure what is wanted.
> > 
> > I want to identify places where the 3rd argument
> > to any sysfs "show" function is used other than
> > by the converted sysfs_emit and sysfs_emit_to calls.
> > 
> > For instance, this assignment of p to buf
> > 
> > drivers/isdn/mISDN/dsp_pipeline.c-static ssize_t
> > drivers/isdn/mISDN/dsp_pipeline.c-attr_show_args(struct device *dev, struct device_attribute *attr, char *buf)
> > drivers/isdn/mISDN/dsp_pipeline.c-{
> > drivers/isdn/mISDN/dsp_pipeline.c-      struct mISDN_dsp_element *elem = dev_get_drvdata(dev);
> > drivers/isdn/mISDN/dsp_pipeline.c-      int i;
> > drivers/isdn/mISDN/dsp_pipeline.c-      char *p = buf;
> > drivers/isdn/mISDN/dsp_pipeline.c-
> > drivers/isdn/mISDN/dsp_pipeline.c:      *buf = 0;
> > drivers/isdn/mISDN/dsp_pipeline.c-      for (i = 0; i < elem->num_args; i++)
> > drivers/isdn/mISDN/dsp_pipeline.c-              p += sprintf(p, "Name:        %s\n%s%s%sDescription: %s\n\n",
> > drivers/isdn/mISDN/dsp_pipeline.c-                           elem->args[i].name,
> > drivers/isdn/mISDN/dsp_pipeline.c-                           elem->args[i].def ? "Default:     " : "",
> > drivers/isdn/mISDN/dsp_pipeline.c-                           elem->args[i].def ? elem->args[i].def : "",
> > drivers/isdn/mISDN/dsp_pipeline.c-                           elem->args[i].def ? "\n" : "",
> > drivers/isdn/mISDN/dsp_pipeline.c-                           elem->args[i].desc);
> > drivers/isdn/mISDN/dsp_pipeline.c-
> > drivers/isdn/mISDN/dsp_pipeline.c-      return p - buf;
> > drivers/isdn/mISDN/dsp_pipeline.c-}
> > 
> > so that this could (likely manually) be converted to:
> > 
> > static ssize_t attr_show_args(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	struct mISDN_dsp_element *elem = dev_get_drvdata(dev);
> > 	int len = 0;
> > 
> > 	for (i = 0; i < elem->num_args; i++) {
> > 		len += sysfs_emit(buf, len, "Name:        %s\n%s%s%sDescription: %s\n\n",
> > 				  elem->args[i].name,
> > 				  elem->args[i].def ? "Default:     " : "",
> > 				  elem->args[i].def ? elem->args[i].def : "",
> > 				  elem->args[i].def ? "\n" : "",
> > 				  elem->args[i].desc);
> > 	}
> > 
> > 	return len;
> > }
> > 
> > And any use of buf passed to another function:
> > 
> > drivers/macintosh/macio_sysfs.c-static ssize_t modalias_show (struct device *dev,
> > drivers/macintosh/macio_sysfs.c-                              struct device_attribute *attr,
> > drivers/macintosh/macio_sysfs.c-                              char *buf)
> > drivers/macintosh/macio_sysfs.c-{
> > drivers/macintosh/macio_sysfs.c-        return of_device_modalias(dev, buf, PAGE_SIZE);
> > drivers/macintosh/macio_sysfs.c-}
> 
> OK, I think that what I suggested could work.

Yes, it did point the way, thanks.

I needed to change the protected block to use a
sysfs_ function specific definition, otherwise
additional similar, but not sysfs <show> function
blocks were also output.

cheers, Joe

----

@dev_protected@
identifier fn,buf;
identifier dev, attr;
position p1,p2;
@@

ssize_t fn@p1(struct device *dev, struct device_attribute *attr, char *buf) {
<...
\(sysfs_emit\|sysfs_emit_at\)(...,buf@p2,...)
...>
}

@@
identifier dev_protected.fn,dev_protected.buf;
position dev_protected.p1;
position p2 != dev_protected.p2;
@@

ssize_t fn@p1(...,char *buf) { <...
*buf@p2
...> }
 


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
