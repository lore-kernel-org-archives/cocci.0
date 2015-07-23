From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 23 Jul 2015 07:26:49 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55B0798B.1010507@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55ACDC1C.1040005@users.sourceforge.net>
 <55AFD615.3070905@users.sourceforge.net>
 <alpine.DEB.2.10.1507221943550.2405@hadrien>
 <55B0798B.1010507@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507230724180.2062@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 23 Jul 2015, SF Markus Elfring wrote:

> > You can use arguments like --show-trying and --debug to see
> > where it is getting stuck, if that is the case.
> 
> How do you think about to try another analysis out with one
> of your test systems?

I don't have your semantic patch.  If you want me to to try something, you 
have to send the semantic patch, even if you have sent it before.

But have you looked at the result of --show-trying and looked at the last 
function that it prints to see why that function might be time consuming?

> "source file"|duration|comment|function
> udev-rules.c|234.2|EXN:Common.Timeout|add_rule
> udev-builtin-usb_id.c|234.4|EXN:Common.Timeout|builtin_usb_id
> udev-builtin-net_id.c|13.0||
> udev-builtin-input_id.c|45.1||
> udevadm-monitor.c|168.5||
> udevadm-control.c|240.0|EXN:Common.Timeout|adm_control
> collect/collect.c|27.1||
> cdrom_id/cdrom_id.c|234.4|EXN:Common.Timeout|main
> ata_id/ata_id.c|252.5|EXN:Common.Timeout|main
> 
> 
> I extended the corresponding SmPL script also with the
> following specifications.
> 
> @show_unstored_return_values@
> binary operator bo;
> expression express;
> ?
> statement es, is;
> ?
> |
>   if (allocation(...) bo express) is else es;

There should not be a semicolon after es.  Since es is a statement, the 
semicolon represents an empty statement, which your code is unlikely to 
contain.

julia
