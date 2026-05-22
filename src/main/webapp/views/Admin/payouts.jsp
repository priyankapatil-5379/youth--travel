<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payout Requests - Youth Travel Admin</title>
    
    <link rel="stylesheet" href="<c:url value='/views/assets/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/views/assets/css/premium-dashboard.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Dosis', sans-serif; background-color: transparent; color: #fff; }
        .admin-layout { display: flex; min-height: 100vh; }
        .admin-sidebar { 
            width: 260px; 
            background: rgba(0,0,0,0.4); 
            backdrop-filter: blur(25px);
            color: #fff; 
            flex-shrink: 0; 
            box-shadow: 4px 0 15px rgba(0,0,0,0.5); 
            border-right: 1px solid rgba(255,255,255,0.1); 
        }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid #222; }
        .sidebar-header img { max-width: 150px; filter: brightness(0) invert(1); }
        .admin-nav { padding: 20px 0; }
        .admin-nav-item { padding: 12px 25px; display: flex; align-items: center; color: #888; text-decoration: none; transition: 0.3s; font-size: 16px; font-weight: 500; }
        .admin-nav-item i { margin-right: 15px; width: 20px; text-align: center; }
        .admin-nav-item:hover, .admin-nav-item.active { background: #1a1a1a; color: #fff; text-decoration: none; }
        .admin-nav-item.active { border-left: 4px solid #ff4d4d; background: rgba(255,77,77,0.1); }
        .admin-main { flex-grow: 1; padding: 40px; overflow-y: auto; }
        .admin-header { margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header h1 { font-weight: 700; color: #fff; margin: 0; font-size: 28px; text-transform: uppercase; }
        .admin-section { 
            background: rgba(0,0,0,0.4); 
            backdrop-filter: blur(15px);
            padding: 30px; 
            border-radius: 24px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); 
            border: 1px solid rgba(255,255,255,0.1); 
        }
        .table thead th { background: transparent !important; border-bottom: 2px solid rgba(255,255,255,0.1); color: #fff; font-weight: 800; text-transform: uppercase; letter-spacing: 1.5px; font-size: 12px; padding: 15px; border-top: none; text-shadow: 0 2px 4px rgba(0,0,0,0.8); }
        .table tbody td { padding: 15px; vertical-align: middle; border-top: 1px solid rgba(255,255,255,0.05); color: #fff; text-shadow: 0 1px 3px rgba(0,0,0,0.5); font-weight: 600; }
    </style>

<link rel="stylesheet" href="<c:url value='/views/assets/css/admin-light.css'/>">
</head>

<body class="premium-theme admin-light-theme">
    <div class="sun-rays-container">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
    </div>
    <div class="admin-layout">
        <aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item">
                    <i class="fa fa-th-large"></i> Dashboard
                </a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item ">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item ">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/payouts'/>" class="admin-nav-item active">
                    <i class="fa fa-money"></i> Payout Requests
                </a>
                <a href="<c:url value='/admin/home-images'/>" class="admin-nav-item ">
                    <i class="fa fa-image"></i> Homepage Photos
                </a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item ">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item">
                        <i class="fa fa-sign-out"></i> Back to Site
                    </a>
                </div>
            </nav>
        </aside>

        <main class="admin-main">
            <header class="admin-header">
                <h1>Payout Requests</h1>
            </header>

            <div class="admin-section">
                <div style="margin-bottom: 20px; display: flex; gap: 10px;">
                    <a href="#" class="btn btn-sm btn-primary" style="background:#ff4d4d; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;">Pending Payouts</a>
                    <a href="#" class="btn btn-sm btn-secondary" style="background:#333; border:none; color:white; padding: 8px 15px; border-radius: 5px; text-decoration: none;">Completed</a>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Vendor Name</th>
                                <th>Request Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vendor" items="${vendors}">
                                <c:set var="earnings" value="${earningsMap[vendor.id]}" />
                                <c:if test="${vendor.status == 'APPROVED' && earnings > 0}">
                                    <tr>
                                        <td><strong>${vendor.businessName}</strong><br><small style="color: #aaa;">Owner: ${vendor.ownerName} | Email: ${vendor.emailId}</small></td>
                                        <td>Today</td>
                                        <td style="color: #28a745; font-weight: bold; font-size: 16px;">₹<fmt:formatNumber value="${earnings}" type="number" maxFractionDigits="2" minFractionDigits="2" /></td>
                                        <td>
                                            <span style="padding: 5px 10px; border-radius: 3px; font-size: 12px; font-weight: bold; background: rgba(255,193,7,0.2); color: #ffc107;">
                                                PENDING
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-sm" style="background: #28a745; color: white; padding: 5px 10px; border-radius: 3px; border: none; font-size: 12px;" onclick="processPayment(this, '₹<fmt:formatNumber value="${earnings}" type="number" maxFractionDigits="2" minFractionDigits="2" />', '${vendor.businessName}')">
                                                <i class="fa fa-check"></i> Process Payment
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    <script src="<c:url value='/views/assets/js/jquery.min.js'/>"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function processPayment(btn, amount, vendor) {
            Swal.fire({
                title: 'Process Payout?',
                text: 'Are you sure you want to wire ' + amount + ' to ' + vendor + '?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#28a745',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, Process Payment!'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: 'Connecting to Gateway...',
                        text: 'Transferring funds securely.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading()
                        }
                    });

                    setTimeout(() => {
                        Swal.fire({
                            title: 'Payment Successful!',
                            text: amount + ' has been transferred to ' + vendor,
                            icon: 'success'
                        });

                        // Visual update
                        let row = $(btn).closest('tr');
                        row.find('td:nth-child(4) span')
                           .text('COMPLETED')
                           .css({ 'background': 'rgba(40,167,69,0.2)', 'color': '#28a745' });
                        
                        $(btn).replaceWith('<span style="color:#28a745; font-weight:bold;"><i class="fa fa-check-circle"></i> Paid</span>');
                        
                        // Move to completed table
                        row.addClass('completed-row');
                        if($('.btn-secondary.active').length) {
                            row.show();
                        } else {
                            setTimeout(() => row.fadeOut(), 1000);
                        }

                    }, 2000);
                }
            });
        }

        // Tab switching logic
        $('.btn-sm').click(function(e) {
            if($(this).text().includes('Pending')) {
                $(this).removeClass('btn-secondary').addClass('btn-primary').css({'background':'#ff4d4d', 'color':'white'});
                $(this).siblings().removeClass('btn-primary').addClass('btn-secondary').css({'background':'#333', 'color':'white'});
                $('tbody tr:not(.completed-row)').fadeIn();
                $('tbody tr.completed-row').hide();
            } else if($(this).text() === 'Completed') {
                $(this).removeClass('btn-secondary').addClass('btn-primary').css({'background':'#ff4d4d', 'color':'white'});
                $(this).siblings().removeClass('btn-primary').addClass('btn-secondary').css({'background':'#333', 'color':'white'});
                $('tbody tr.completed-row').fadeIn();
                $('tbody tr:not(.completed-row)').hide();
                if($('tbody tr.completed-row').length === 0) {
                    Swal.fire('No Data', 'No completed payouts found in the current session.', 'info');
                }
            }
        });
    </script>
</body>
</html>
