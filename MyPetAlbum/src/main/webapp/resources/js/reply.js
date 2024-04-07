/**
 * 

 
 			
	replyService.add(
				{reply:"JS TEST", replyer:"tester", f_no:f_no},
				function(result){
					alert("RESULT: " + result);
				}
			);
			 
			
			 replyService.getList({f_no:f_no, page:1}, function(list) {
				
				 for(var i=0, len = list.length||0; i<len; i++){
					 console.log(list[i]);
				 }
				 
			 }); 
			 
	 replyService.remove(1, function(count){
				 
				 console.log(count);
				 
				 if (count === "success"){
					 alert("REMOVED");
				 }
			 }, function(err) {
				 alert("ERROR");
			 });
				 
				  
			 	  
	 replyService.update({
				 rno : 2,
				 f_no : f_no,
				 reply : "Modified Reply......."
			 }, function(result){
				
				 alert("수정완료");
			 }); 
			 
  */
 console.log("Reply Module.......");
 
 var replyService = (function(){
 
 	function add(reply, callback, error){
 		console.log("add reply...........");
 		
 		$.ajax({
 			type : 'post',
 			url : '/replies/new',
 			data : JSON.stringify(reply),
 			contentType : "application/json; charset=utf-8",
 			success : function(result, status, xhr){
 				if(callback){
 					callback(result);
 				}
 			},
 			error : function(xhr, status, er) {
 				if(error) {
 					error(er);
 				}
 			}
 		})
 	}
 	
 	function getList(param, callback, error) {
 		
 		var f_no = param.f_no;
 		var page = param.page || 1;
 		
 		$.getJSON("/replies/pages/" + f_no + "/" + page + ".json",
 			function(data) {
 			 if (callback) {
 			 		callback(data);
 			 }
 			}).fail(function(xhr, status, err) {
 		   if(error) {
 		   	 error();
 		   	}
 		   });	
 	}
 	
 	function remove(rno, callback, error) {
 		$.ajax({
 			type : 'delete',
 			url : '/replies/' + rno,
 			success : function(deleteResult, status, xhr){
 				if(callback){
 					callback(deleteResult);
 				}
 			},
 			error : function(xhr, status, er) {
 				if(error) {
 					error(er);
 				 }
 			}
	 	});
 	}	
 	
 	function update(reply, callback, error) {
 		console.log("RNO: " + reply.rno);
 		
 		$.ajax({
 			type : 'put',
 			url : '/replies/' + reply.rno,
 			data : JSON.stringify(reply),
 			contentType : "application/json; charset=utf-8",
 			success :  function(result, status, xhr) {
 				if(callback){
 					callback(result);
 				}
 			},
 			error : function(xhr, status, er){
 				if(error) {
 					error(er);
 				}
 			}
 		});
 	}
 	
 	function get(rno, callback, error){
 		
 		$.get("/replies/" + rno + ".json", function(result) {
 		
 			if(callback) {
 				callback(result);
 			}
 		}).fail(function(xhr, status, err) {
 		   if(error) {
 		   		error();
 		   	}
 		 });
 	}
 	
	 
 	return {
 		add:add,
 		getList : getList,
 		remove : remove,
 		update : update,
 		get : get
 	};
 })();