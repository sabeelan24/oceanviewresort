<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice - Ocean View Resort</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 40px;
            background-color: #f4f7f6;
        }
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            font-size: 16px;
            background-color: #fff;
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 2px solid #007bff;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .invoice-header h1 {
            margin: 0;
            color: #007bff;
            font-size: 28px;
        }
        .hotel-info p, .guest-info p {
            margin: 5px 0;
        }
        .invoice-details {
            margin-bottom: 30px;
        }
        .invoice-details table {
            width: 100%;
            border-collapse: collapse;
        }
        .invoice-details th, .invoice-details td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        .invoice-details th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .total-section {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .total-table {
            width: 300px;
        }
        .total-table tr td:first-child {
            font-weight: bold;
            text-align: right;
            padding-right: 20px;
        }
        .total-table .grand-total {
            font-size: 20px;
            color: #d9534f;
            border-top: 2px solid #eee;
            padding-top: 10px;
        }
        .footer {
            margin-top: 50px;
            text-align: center;
            font-size: 12px;
            color: #777;
        }
        .no-print {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }
        .btn-print { background-color: #007bff; }
        .btn-back { background-color: #6c757d; }

        @media print {
            body { background-color: #fff; padding: 0; }
            .invoice-box { box-shadow: none; border: none; }
            .no-print { display: none; }
        }
    </style>
</head>
<body>

    <div class="no-print">
        <button onclick="window.print()" class="btn btn-print">Print Invoice</button>
    </div>

    <div class="invoice-box">
        <div class="invoice-header">
            <div class="hotel-info">
                <h1>OCEAN VIEW RESORT</h1>
                <p>123 Serenity Beach Road</p>
                <p>Tropical Paradise, FL 33101</p>
                <p>Phone: +1 (555) 123-4567</p>
            </div>
            <div class="invoice-meta" style="text-align: right;">
                <h2>INVOICE</h2>
                <p><strong>Invoice #:</strong> ${reservation.resId}</p>
                <p><strong>Date:</strong> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" /></p>
            </div>
        </div>

        <div class="guest-info">
            <h3>Bill To:</h3>
            <p><strong>${reservation.guestName}</strong></p>
            <p>${reservation.guestContact}</p>
        </div>

        <div class="invoice-details" style="margin-top: 30px;">
            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Nights</th>
                        <th>Rate/Night</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <strong>Room: ${reservation.roomNumber}</strong><br>
                            <small>${reservation.roomTypeName}</small>
                        </td>
                        <td>${reservation.checkIn}</td>
                        <td>${reservation.checkOut}</td>
                        <td>${nights}</td>
                        <td>LKR <fmt:formatNumber value="${reservation.basePrice}" pattern="#,###.00" /></td>
                        <td>LKR <fmt:formatNumber value="${subtotal}" pattern="#,###.00" /></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="total-section">
            <table class="total-table">
                <tr>
                    <td>Subtotal:</td>
                    <td>LKR <fmt:formatNumber value="${subtotal}" pattern="#,###.00" /></td>
                </tr>
                <tr>
                    <td>Taxes (10%):</td>
                    <td>LKR <fmt:formatNumber value="${tax}" pattern="#,###.00" /></td>
                </tr>
                <tr class="grand-total">
                    <td>Total Amount:</td>
                    <td><strong>LKR <fmt:formatNumber value="${grandTotal}" pattern="#,###.00" /></strong></td>
                </tr>
            </table>
        </div>

        <div class="footer">
            <p>Thank you for choosing Ocean View Resort!</p>
            <p>If you have any questions about this invoice, please contact our front desk.</p>
        </div>
    </div>

</body>
</html>