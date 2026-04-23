# Hardening Automation

## Project purpose

This project aims to automate the hardening of a Linux system through a centralized script. 
It performs essential administrative tasks such as updating packages, removing unauthorized users, and enforcing security policies based on a predefined configuration. 
By standardizing these operations, the script helps ensure consistency, improve system security, and reduce the risk of manual errors. 
Additionally, it generates a detailed report of all actions performed, 
providing clear visibility into the system’s state and any changes applied during execution.

## Files

The program follows this structure :

```
hardening/
├── harden.sh              # Main entry point
├── config/
│   └── harden.cfg         # Configuration variables
├── lib/
│   ├── network.sh         # Network hardening functions
│   ├── ssh.sh             # SSH hardening functions
│   ├── identity.sh        # User/password functions
│   ├── system.sh          # System hardening functions
│   └── audit_report.sh    # Audit report functions
└── README.md              # Documentation
```

## Usage

First :
```
cd hardening
```

Then :

```
./harden.sh
```

To see the generated report :

```
cat audit_report.txt
```
