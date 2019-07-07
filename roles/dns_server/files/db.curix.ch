$TTL 5m ; Default TTL

; SOA, NS and A record for DNS server itself
@                 3600 IN SOA  ns admin ( 2014010800 ; Serial
                                          3600       ; Refresh
                                          3600       ; Retry
                                          3600       ; Expire
                                          300 )      ; Minimum TTL
@                 3600 IN NS   ns
ns                3600 IN A    192.168.200.171 ; IPv4 address of BIND server

; bono
; ====
;
; Per-node records - not required to have both IPv4 and IPv6 records
bono-1                 IN A     192.168.200.192
;
; Cluster A and AAAA records - UEs that don't support RFC 3263 will simply
; resolve the A or AAAA records and pick randomly from this set of addresses.
@                      IN A     192.168.200.192
;
; NAPTR and SRV records - these indicate a preference for TCP and then resolve
; to port 5060 on the per-node records defined above.
@                      IN NAPTR 1 1 "S" "SIP+D2T" "" _sip._tcp
@                      IN NAPTR 2 1 "S" "SIP+D2U" "" _sip._udp
_sip._tcp              IN SRV   0 0 5060 bono-1
_sip._udp              IN SRV   0 0 5060 bono-1

; sprout
; ======
;
; Per-node records - not required to have both IPv4 and IPv6 records
sprout-1               IN A     192.168.200.154
;
; Cluster A and AAAA records - P-CSCFs that don't support RFC 3263 will simply
; resolve the A or AAAA records and pick randomly from this set of addresses.
sprout                 IN A     192.168.200.154
;
; Cluster A and AAAA records - P-CSCFs that don't support RFC 3263 will simply
; resolve the A or AAAA records and pick randomly from this set of addresses.
scscf.sprout           IN A     192.168.200.154
;
; NAPTR and SRV records - these indicate TCP support only and then resolve
; to port 5054 on the per-node records defined above.
sprout                 IN NAPTR 1 1 "S" "SIP+D2T" "" _sip._tcp.sprout
_sip._tcp.sprout       IN SRV   0 0 5054 sprout-1
;
; NAPTR and SRV records for S-CSCF - these indicate TCP support only and
; then resolve to port 5054 on the per-node records defined above.
scscf.sprout           IN NAPTR 1 1 "S" "SIP+D2T" "" _sip._tcp.scscf.sprout
_sip._tcp.scscf.sprout IN SRV   0 0 5054 sprout-1
;
; Cluster A and AAAA records - P-CSCFs that don't support RFC 3263 will simply
; resolve the A or AAAA records and pick randomly from this set of addresses.
icscf.sprout           IN A     192.168.200.154
;
; NAPTR and SRV records for I-CSCF - these indicate TCP support only and
; then resolve to port 5052 on the per-node records defined above.
icscf.sprout           IN NAPTR 1 1 "S" "SIP+D2T" "" _sip._tcp.icscf.sprout
_sip._tcp.icscf.sprout IN SRV   0 0 5052 sprout-1

; dime
; =========
;
; Per-node records - not required to have both IPv4 and IPv6 records
dime-1                 IN A     192.168.200.158
;
; Cluster A and AAAA records - sprout, bono and ellis pick randomly from these.
hs                     IN A     192.168.200.158
ralf                   IN A     192.168.200.158
;
; (No need for NAPTR or SRV records as dime doesn't handle SIP traffic.)

; homer
; =====
;
; Per-node records - not required to have both IPv4 and IPv6 records
homer-1                IN A     192.168.200.186
;
; Cluster A and AAAA records - sprout picks randomly from these.
homer                  IN A     192.168.200.186
;
; (No need for NAPTR or SRV records as homer doesn't handle SIP traffic.)

; vellum
; =====
;
; Per-node records - not required to have both IPv4 and IPv6 records
vellum-1               IN A     192.168.200.137
;
; Cluster A and AAAA records - sprout, homer and dime pick randomly from these.
vellum                 IN A     192.168.200.137
;
; (No need for NAPTR or SRV records as vellum doesn't handle SIP traffic.)

; ellis
; =====
;
; ellis is not clustered, so there's only ever one node.
;
; Per-node record - not required to have both IPv4 and IPv6 records
ellis                IN A     192.168.200.105
;
; "Cluster"/access A and AAAA record
ellis                  IN A     192.168.200.105
