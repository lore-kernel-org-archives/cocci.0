Return-Path: <SRS0=W5OG=D2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE2C433DF
	for <cocci@archiver.kernel.org>; Mon, 19 Oct 2020 15:17:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053E82231B
	for <cocci@archiver.kernel.org>; Mon, 19 Oct 2020 15:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053E82231B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09JFGsI1006549;
	Mon, 19 Oct 2020 17:16:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 27A1D75B4;
	Mon, 19 Oct 2020 17:16:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D632445E
 for <cocci@systeme.lip6.fr>; Mon, 19 Oct 2020 17:16:52 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0139.hostedemail.com
 [216.40.44.139])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09JFGoWt021430
 for <cocci@systeme.lip6.fr>; Mon, 19 Oct 2020 17:16:51 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id ADECB182CED2A;
 Mon, 19 Oct 2020 15:16:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hands03_1d1673927238
X-Filterd-Recvd-Size: 3422
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf15.hostedemail.com (Postfix) with ESMTPA;
 Mon, 19 Oct 2020 15:16:48 +0000 (UTC)
Message-ID: <b4a74066be2ff9bff703e72c15296c49b6dc39ee.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Tom Rix <trix@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Oct 2020 08:16:47 -0700
In-Reply-To: <c02aed9b-ab6c-1054-1e8a-4006f2a75f94@redhat.com>
References: <20201017160928.12698-1-trix@redhat.com>
 <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
 <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
 <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
 <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
 <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
 <c02aed9b-ab6c-1054-1e8a-4006f2a75f94@redhat.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 19 Oct 2020 17:16:54 +0200 (CEST)
X-Greylist: Delayed for 46:51:50 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Mon, 19 Oct 2020 17:16:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] checkpatch: Allow --fix removal of unnecessary
 break statements
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

On Mon, 2020-10-19 at 05:55 -0700, Tom Rix wrote:
> On 10/18/20 1:19 PM, Joe Perches wrote:
> > On Sun, 2020-10-18 at 13:07 -0700, Tom Rix wrote:
> > > I like!
> > []
> > > could add a '|break' here to catch the couple
> > []
> > > break;
> > > 
> > > break;
> > Unfortunately, checkpatch is really stupid and it
> > wouldn't catch those
> > cases as there are blank lines
> > between the existing consecutive break
> > statements.
> > 
> > It would catch
> > 
> > 	break;
> > 	break;
> > 
> > but there aren't any of those so it seems unlikely
> > to be a very useful addition.
> 
> Unusual, but there are a couple of these.
> 
> Here's one from my rfc diff
> 
> diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
> index 1be82113c59a..817d8259758c 100644
> --- a/sound/soc/codecs/wcd-clsh-v2.c
> +++ b/sound/soc/codecs/wcd-clsh-v2.c
> @@ -478,11 +478,10 @@ static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
>          wcd_clsh_state_hph_l(ctrl, req_state, is_enable, mode);
>          break;
>      case WCD_CLSH_STATE_HPHR:
>          wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
>          break;
> -        break;
>      case WCD_CLSH_STATE_LO:
>          wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
>          break;
>      default:
>          break;

Thanks, I guess my grep skilz ain't good enough.

I used:
.
$ git grep -A1 -n "break;" | grep -B1 -P '\-\d+\-.*break;'

but that doesn't work because the line after the
first break is also break then that line also matches
break; too so the second grep expecting to match the
'-<line#>- break;' doesn't work.  That line also
matches the first pattern so it's ':<line#>:'

Duh...

This seems to work though:

$ git grep -n -P '^\s*break;\s*$' | \
  awk -F: '{if ($1==o1 && $2==o2+1) {print $0;} o1=$1; o2=$2;}'
drivers/gpu/drm/amd/display/dc/dce/dce_transform.c:1333:			break;
drivers/media/usb/gspca/sn9c20x.c:1864:		break;
drivers/video/fbdev/pm2fb.c:479:		break;
drivers/video/fbdev/pm2fb.c:501:		break;
sound/soc/codecs/wcd-clsh-v2.c:483:		break;

Anyway it doesn't hurt to add it.

cheers, Joe

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
