From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 5 Dec 2014 08:18:18 +0100 (CET)
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <1417741951.2721.30.camel@perches.com>
References: <1417741951.2721.30.camel@perches.com>
Message-ID: <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 4 Dec 2014, Joe Perches wrote:

> Is it possible for coccinelle to look at the name
> of a function that might be embedded in a format?
> 
> ie for:
> 
> void testme(void)
> {
> 	printf("testme: some message\n");
> }
> 
> Can it find the "testme" embedded in a format string?

Yes, by using python/ocaml:

@r@
char [] c;
position p;
identifier f;
@@

f(...,c at p,...)

@script:ocaml@
c << r.c;
p << r.p;
@@

let ce = (List.hd p).current_element in
if List.length(Str.split_delim (Str.regexp ce) c) > 1
then Printf.printf "%s:%d: %s\n"
       (List.hd p).file (List.hd p).line c

Here are some results:

drivers/net/wireless/zd1211rw/zd_usb.c:1573: "%s usb_exit()\n"
drivers/net/wireless/zd1211rw/zd_usb.c:1551: "%s usb_init()\n"
drivers/net/wireless/zd1211rw/zd_usb.c:1453: "disconnected\n"
drivers/net/wireless/rtlwifi/rtl8723be/dm.c:800: 
"rtl8723be_dm_txpower_tracking_callback_thermalmeter\n"
drivers/net/wireless/rtlwifi/rtl8723be/fw.c:461: 
"rtl8723be_set_fw_rsvdpagepkt(): HW_VAR_SET_TX_CMD: ALL\n"
drivers/net/wireless/rtlwifi/rtl8723be/fw.c:464: 
"rtl8723be_set_fw_rsvdpagepkt(): HW_VAR_SET_TX_CMD: ALL\n"
drivers/net/wireless/rtlwifi/rtl8723be/phy.c:451: 
"<===_rtl8723be_phy_convert_txpower_dbm_to_relative_value()\n"
drivers/net/wireless/rtlwifi/rtl8192ee/fw.c:721: 
"rtl92ee_set_fw_rsvdpagepkt(): HW_VAR_SET_TX_CMD: ALL\n"
drivers/net/wireless/rtlwifi/rtl8192ee/fw.c:724: 
"rtl92ee_set_fw_rsvdpagepkt(): HW_VAR_SET_TX_CMD: ALL\n"
drivers/net/wireless/rtlwifi/rtl8192ee/phy.c:635: 
"<==phy_convert_txpwr_dbm_to_rel_val()\n"

The idea would be to replace these by %s and __func__?  That would also be 
possible.

julia
