


(function(DailyExpenses, $, undefined) {
	var parent = new Base();

	var dailyExpenses = null;
	var instance = function() {
		dailyExpenses = this;
	};

	instance.prototype = parent;
	instance.prototype.constructor = Base;

	$.extend(true, instance.prototype, {

	    _documentReadyFunctions : {
			dailyExpenses_documentReady : function(_instance) {

                $('#dateEntry').datepicker();
                $('#dateEntryList').datepicker();
                $('#dateReportStart').datepicker();
                $('#dateReportEnd').datepicker();
                $('#amount').numeric();

                var expenseTable = $('#dailyExpenseList').dataTable({
                    "bPaginate": false,
                    "ajax": '/fpw/expenses/list?expenseDate='+$('#dateEntryList').val(),
                     "columnDefs": [
                        { "className": 'text-right', targets: [1] },
                        { "className": 'text-center', targets: [0,2] },
                        { "targets": 2,
                            "render": function ( data, type, full, meta ) {
                              return '<a href="#" class="removeDailyExpense" data-id="'+data+'"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>';
                            }
                        }
                     ]
                });

                $('#addDailyExpense').click(function(e){
                    e.preventDefault();
                    var postdata = { dateEntry: $('#dateEntry').val(), amount: $('#amount').val(), items: $('#items').val() }
                    $.post('/fpw/expenses/create', postdata, function(data){
                        if(data.success) {
                            $('#amount').val('');
                            $('#items').val('');
                            $('#alertMessage').show();
                            $('#dateEntryList').val(postdata.dateEntry);
                            var newListUrl = '/fpw/expenses/list?expenseDate='+postdata.dateEntry;
                            expenseTable.api().ajax.url(newListUrl).load();
                        }
                    });
                });

                $(document).on("click", ".removeDailyExpense", function(e){
                    e.preventDefault();
                    $.post('/fpw/expenses/delete', { id: $(this).data('id') }, function(data){
                         var newListUrl = '/fpw/expenses/list?expenseDate='+$('#dateEntryList').val();
                         expenseTable.api().ajax.url(newListUrl).load();
                    });
                });

                $('#refreshExpenseList').click(function(e){
                    e.preventDefault();
                    var newListUrl = '/fpw/expenses/list?expenseDate='+$('#dateEntryList').val();
                    expenseTable.api().ajax.url(newListUrl).load();
                });

                $('#exportDailyExpense').click(function(e){
                    e.preventDefault();
                    $('#csvModal').modal('show');
                });
                $('#generateCsv').click(function(e){
                    e.preventDefault();
                    var newCsvUrl = '/fpw/expenses/csv';
                    newCsvUrl += "?fromDate="+$('#dateReportStart').val();
                    newCsvUrl += "&toDate="+$('#dateReportEnd').val();
                    location.href = newCsvUrl;
                });
			}
        }
	});

    window.DailyExpenses = instance;
}(window.DailyExpenses = window.DailyExpenses || {}, jQuery));