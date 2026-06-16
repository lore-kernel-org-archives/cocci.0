Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088F1CD98DA
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2026 13:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t/vFL7FT02g1b6kJN0iXLKScFMFRuT4r4xGy9remOIY=;
  b=bHtd+8z8IVxOZPvZ+0UkeVlm+QLr7CZO3WIWkGVP9Vqh/9Xb50lG31hJ
   ZGQ9kdkSjm1kHbP5hfpi5CMJG3psQggMGEWkuEKLpGZasJTjauekEpx97
   go11+AcJsXDuV96Um28MR3twEh78Y5fd/D6/jc4p3/FgK8jBSLRJV2SZe
   c=;
X-CSE-ConnectionGUID: vL6ljWScQfG2HRUq71xo0g==
X-CSE-MsgGUID: fGHa35jjQVuPpTzepqmfRw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,208,1774306800"; 
   d="scan'208";a="281827185"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2026 15:20:55 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C954E8188E; Tue, 16 Jun 2026 15:20:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 79F7580637
	for <cocci@sympa.inria.fr>; Tue, 16 Jun 2026 15:20:50 +0200 (CEST)
X-CSE-ConnectionGUID: cRVF99vCR7a4sZ/X09v3fQ==
X-CSE-MsgGUID: ZTRMO1uETZCN60kLSIILoQ==
X-IronPort-AV: E=Sophos;i="6.24,208,1774306800"; 
   d="scan'208";a="281827140"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:20:50 +0200
Date: Tue, 16 Jun 2026 15:20:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de>
Message-ID: <401e445-92bb-94b4-1fda-c5bd24f32bc0@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de> <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr> <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1024228654-1781616050=:23663"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3579
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/pdmEvFoVggwcyDv643853g>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1024228654-1781616050=:23663
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 16 Jun 2026, Markus Elfring wrote:

> > So why do you think that the number of relevant files diminshed?
>
> I got into the mood to try another SmPL script variant out.
>
>
> @initialize:python@
> @@
> import sys
> delimiter = "|"
>
> def display_data(source1, source2):
>     place1 = source1[0]
>     place2 = source2[0]
> #    if place1 == place2:
>     if (place1.line == place2.line) and (place1.column == place2.column):
>        sys.stdout.write(delimiter.join(("same position",
>                                         place1.current_element,
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1),
>                                         "-",
>                                         "-"
>                                        ))
>                         + "\n")
>
>     else:
>        sys.stdout.write(delimiter.join(("update candidate",
>                                         place1.current_element,
>                                         place1.file,
>                                         place1.line,
>                                         str(int(place1.column) + 1),
>                                         place2.line,
>                                         str(int(place2.column) + 1)))
>                         + "\n")
>
> @searching exists@
> expression e, x;
> identifier item, rc;
> position p1, p2;
> @@
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p1(item);
>  return rc;
>  }
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p2(item);
>  return rc;
>  }
>
> @script:python collection@
> p1 << searching.p1;
> p2 << searching.p2;
> @@
> display_data(p1, p2)
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches5.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches5-20260615.txt 2> …/Projekte/Bau/Linux/scripts/Coccinelle/list_selected_duplicate_statements_in_if_branches5-errors-20260615.txt
>
> real    9m40,850s
> user    32m55,318s
> sys     0m17,383s
>
>
> The provided data could be converted into a pivot table.
> I transformed such information into the following report.

Which means what?

>
>
> file|function name|incidence
> fs/hpfs/dnode.c|map_fnode_dirent|40
> drivers/media/dvb-frontends/cxd2880/cxd2880_top.c|cxd2880_attach|15
> drivers/mtd/tests/pagetest.c|crosstest|10
> drivers/media/pci/cx88/cx88-cards.c|cx88_core_create|10
> drivers/usb/serial/io_ti.c|do_download_mode|9
> |wmid3_set_device_status|6
> mm/vmalloc.c|pcpu_get_vm_areas|5
> drivers/net/ethernet/intel/idpf/idpf_lib.c|idpf_vport_alloc|4
> fs/jfs/jfs_dtree.c|jfs_readdir|4
> sound/soc/amd/acp/acp-platform.c|acp_dma_open|3
> drivers/gpu/drm/amd/amdgpu/atom.c|amdgpu_atom_parse|3
> drivers/gpu/drm/radeon/atom.c|atom_parse|3
> drivers/s390/net/ctcm_mpc.c|ctcmpc_init_mpc_group|3
> drivers/tty/n_gsm.c|gsm_alloc_mux|3
> |hp_init_bios_package_attribute|3
> net/mac80211/iface.c|ieee80211_add_virtual_monitor|3
> drivers/nvme/target/fabrics-cmd-auth.c|nvmet_auth_reply|3
> net/sched/act_ife.c|tcf_ife_init|3
> drivers/iommu/tegra-smmu.c|tegra_smmu_domain_alloc_paging|3
> drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c|ttusb_probe|3
> drivers/scsi/device_handler/scsi_dh_alua.c|alua_rtpg|2
> drivers/media/pci/cobalt/cobalt-driver.c|cobalt_probe|2
> drivers/media/pci/cx18/cx18-driver.c|cx18_probe|2
> drivers/media/dvb-frontends/dib9000.c|dib9000_attach|2
> kernel/trace/trace_events_trigger.c|event_enable_trigger_parse|2
> net/sched/cls_fw.c|fw_change|2
> arch/powerpc/platforms/powernv/opal-imc.c|imc_pmu_create|2
> drivers/media/pci/ivtv/ivtv-driver.c|ivtv_probe|2
> drivers/gpu/drm/gma500/psb_intel_sdvo.c|psb_intel_sdvo_init|2
> drivers/staging/rtl8723bs/core/rtw_xmit.c|rtw_mgmt_xmitframe_coalesce|2
> drivers/soundwire/intel_init.c|sdw_intel_probe_controller|2
> drivers/crypto/hisilicon/sec/sec_algs.c|sec_alg_skcipher_crypto|2
> sound/sh/aica.c|snd_aica_probe|2
> |sof_link_load|2
> drivers/platform/x86/toshiba_bluetooth.c|toshiba_bt_rfkill_probe|2
> net/wireless/core.c|wiphy_new_nm|2
>
>
> Can such technical details be helpful for further improvements
> also according to the Coccinelle software?
>
> Regards,
> Markus
>
--8323329-1024228654-1781616050=:23663--
