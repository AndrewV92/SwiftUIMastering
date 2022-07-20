//
//  JSONwithCombine.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 20.07.2022.
//

//"https://jsonplaceholder.typicode.com/posts"
import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class JSONWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        //1. Create the publisher
        URLSession.shared.dataTaskPublisher(for: url)
        //2. Subscribe publisher on background thread(it done automatically, but for lesson we do anyway
            ///.subscribe(on: DispatchQueue.global(qos: .background))
        //3. Recieve on main thread
            .receive(on: DispatchQueue.main)
        //4. tryMap (check that the data is good)
            /*
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
             */
            .tryMap(handleOutput)
        //5. Decode (decode data into PostModels)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        //5.5 Replace error with dummy data
            //.replaceError(with: [])
        //6. sink (put the item into our app)
            .sink { (completion) in
                //no need for completion block if we replace error, just sink with receiveValue only
                //print("Completion: \(completion)")
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("There was an error \(error)") //prob alert
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
        //7. store (cancel subscription if needed)
            .store(in: &cancellables)
    }
    
    /*
     func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
     */
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct JSONwithCombine: View {
    
    @StateObject var viewModel = JSONWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct JSONwithCombine_Previews: PreviewProvider {
    static var previews: some View {
        JSONwithCombine()
    }
}
